extends Node
class_name CampaignManager

@export var level_data_directory: String = "res://modules/campaign/data"
@export var first_level: LevelData
@export var level_container: Node
@export var autostart: bool = false

const logmod := "campaign"
const group := "campaign"

enum CAMPAIGN_STATE {
    INVALID,
    INACTIVE_LOST,
    INACTIVE_WON,
    ACTIVE,
}

enum LEVEL_STATE {
    INVALID,
    STARTED,
    RUNNING,
    FINISHED,
    PERKS_STARTED,
    PERKS_FINISHED,
    LOADING_NEXT_LEVEL,
}

func campaign_state_to_string(state: CAMPAIGN_STATE) -> StringName:
    return CAMPAIGN_STATE.keys()[state]

func level_state_to_string(state: LEVEL_STATE) -> StringName:
    return LEVEL_STATE.keys()[state]

func start():
    if first_level == null || first_level.scene == null:
        Logger.error("tried to start the campaign, but the first level is not set", logmod)
    
    if _campaign_state == CAMPAIGN_STATE.ACTIVE:
        Logger.error("tried to start the campaign when it's already running?", logmod)
        return
        
    _current_level_data = null
    _current_level_state = LEVEL_STATE.INVALID
    
    _change_campaign_state(CAMPAIGN_STATE.ACTIVE)
    _next_level()
    
func next_level():
    _next_level()
    
var _campaign_state: CAMPAIGN_STATE = CAMPAIGN_STATE.INVALID

var _current_level_state: LEVEL_STATE = LEVEL_STATE.INVALID
var _current_level_data: LevelData

# Key is the path to the LevelData
var _level_data: Dictionary[StringName, LevelData]

func _enter_tree() -> void:
    Logger.add_module(logmod, Logger.VERBOSE)
    
    # If you need to access this, grab it from our group
    add_to_group(group)
    
    _load_data(level_data_directory)

func _ready():
    if autostart:
        start()

func _exit_tree() -> void:
    pass
    
func _change_campaign_state(new: CAMPAIGN_STATE) -> void:
    var old = _campaign_state
    _campaign_state = new
    
    Logger.verbose("Changing campaign state from %s to %s" % [campaign_state_to_string(old), campaign_state_to_string(new)], logmod)
    EventBus.campaign_state_changed.emit(_current_level_data, old, new)
    
func _change_level_state(new: LEVEL_STATE) -> void:
    var old = _current_level_state
    _current_level_state = new
    
    Logger.verbose("Changing level state %s from %s to %s" % [_current_level_data.display_name, level_state_to_string(old), level_state_to_string(new)], logmod)
    EventBus.campaign_level_state_changed.emit(_current_level_data, old, new)
    
func _next_level() -> void:
    if _campaign_state != CAMPAIGN_STATE.ACTIVE:
        Logger.error("Tried to go to the next level but the campaign state is not active (was %s instead)" % campaign_state_to_string(_campaign_state))
    
    if _current_level_data != null: # will be null on the first call
        _change_level_state(LEVEL_STATE.LOADING_NEXT_LEVEL)
    
    if !_current_level_data:
        _current_level_data = first_level
        Logger.verbose("Starting the first level (%s)" % _current_level_data.display_name, logmod)
        _change_level_node(_current_level_data.scene)
    elif _current_level_data.next_level:
        _current_level_data = _current_level_data.next_level
        Logger.verbose("Starting the next level (%s)" % _current_level_data.display_name, logmod)
        _change_level_node(_current_level_data.scene)
    else:
        _change_campaign_state(CAMPAIGN_STATE.INACTIVE_WON)
        _change_level_state(LEVEL_STATE.INVALID)
        Logger.verbose("Campaign won!", logmod)
        return
    
    _change_level_state(LEVEL_STATE.STARTED)

func _change_level_node(new_level: PackedScene):    
    for child in level_container.get_children():
        child.queue_free()
    
    # we don't want both levels existing on the same frame, so wait until the queue_free deletes the old one 
    await get_tree().process_frame
    
    var new_level_node = new_level.instantiate()
    level_container.add_child(new_level_node)
    
func _load_data(directory_path: StringName) -> void:
    _level_data.clear()
    
    var dir = DirAccess.open(directory_path)
    if dir == null:
        push_error("Failed to open level data directory: " + directory_path)
        return
    
    dir.list_dir_begin()
    var file_name = dir.get_next()
    
    while file_name != "":
        if file_name.ends_with(".tres"):
            var file_path = directory_path.path_join(file_name)
            var data = load(file_path) as LevelData
            
            if data != null:
                if _level_data.get(data.resource_path) == null:
                    _level_data[data.resource_path] = data
                    Logger.verbose("Loaded level data: %s @ %s" % [data.display_name, data.resource_path], logmod)
                else:
                    Logger.warn("Failed to load level data from %s - Already Loaded" % file_path, logmod)
            else:
                Logger.error("Failed to load level data from %s - Invalid or Doesn't Exist" % file_path, logmod)
        
        file_name = dir.get_next()
    
    EventBus.campaign_levels_loaded.emit()
