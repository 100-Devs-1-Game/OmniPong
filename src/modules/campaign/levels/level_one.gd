extends Node2D


func _ready():
    var mngr: CampaignManager = get_tree().get_first_node_in_group(CampaignManager.group)
    mngr.next_level()
