extends Control
## 主菜单场景

@onready var title_label: Label = $VBoxContainer/TitleLabel
@onready var start_btn: Button = $VBoxContainer/StartButton
@onready var continue_btn: Button = $VBoxContainer/ContinueButton
@onready var codex_btn: Button = $VBoxContainer/CodexButton
@onready var settings_btn: Button = $VBoxContainer/SettingsButton

func _ready():
    start_btn.pressed.connect(_on_start_pressed)
    continue_btn.pressed.connect(_on_continue_pressed)
    codex_btn.pressed.connect(_on_codex_pressed)
    settings_btn.pressed.connect(_on_settings_pressed)

func _on_start_pressed():
    print("开始新游戏")
    # TODO: 切换到选将场景
    get_tree().change_scene_to_file("res://scenes/select_leader.tscn")

func _on_continue_pressed():
    print("继续游戏")
    # TODO: 读存档继续

func _on_codex_pressed():
    print("武将图鉴")
    # TODO: 切换到图鉴场景

func _on_settings_pressed():
    print("设置")
    # TODO: 切换到设置场景
