extends Node
## 全局游戏状态单例（Autoload）
## 所有场景共享的游戏数据

# —— 运行时状态 ——
var money: int = 4              # 粮草
var city_index: int = 0          # 当前城池（0-7）
var round_index: int = 0         # 当前关卡（0先锋/1守将/2城主）
var plays_left: int = 4          # 剩余出牌次数
var discards_left: int = 3      # 剩余弃牌次数
var total_score: int = 0         # 本局累计战力
var generals: Array = []         # 已招募武将列表
var active_bonds: Array = []     # 已激活羁绊

# —— 将领选择 ——
var leader_name: String = "刘备"
var leader_form: String = "织席贩履"

# —— 存档 ——
var medals: int = 0              # 功勋
var unlocked_generals: Array = []  # 已解锁武将名
var unlocked_leaders: Array = []   # 已解锁将领名

# —— 数值表（从 JSON 加载）——
var game_data: Dictionary = {}

func _ready():
    load_game_data()
    load_save()

func load_game_data():
    var file = FileAccess.open("res://data/game_data.json", FileAccess.READ)
    if file:
        var text = file.get_as_text()
        game_data = JSON.parse_string(text)
        print("数值表加载成功，武将数量: ", game_data.generals.size())

func load_save():
    if FileAccess.file_exists("user://save.json"):
        var file = FileAccess.open("user://save.json", FileAccess.READ)
        var text = file.get_as_text()
        var data = JSON.parse_string(text)
        if data:
            medals = data.get("medals", 0)
            unlocked_generals = data.get("unlocked_generals", [])
            unlocked_leaders = data.get("unlocked_leaders", [])
            print("存档加载成功，功勋: ", medals)

func save_game():
    var data = {
        "medals": medals,
        "unlocked_generals": unlocked_generals,
        "unlocked_leaders": unlocked_leaders
    }
    var file = FileAccess.open("user://save.json", FileAccess.WRITE)
    file.store_string(JSON.stringify(data))
    print("存档保存成功")

func start_new_run(leader: String, form: String):
    leader_name = leader
    leader_form = form
    money = game_data.start_money
    city_index = 0
    round_index = 0
    total_score = 0
    generals = []
    plays_left = game_data.plays_per_round
    discards_left = game_data.discards_per_round
    print("新一局开始：将领 ", leader_name, " - ", leader_form)

func get_target_score() -> int:
    var city = game_data.cities[city_index]
    var base = city.targets[round_index]
    return int(base * game_data.difficulty_mult)

func get_refresh_cost() -> int:
    var cost = game_data.refresh_cost
    if leader_name == "刘备" and leader_form == "织席贩履":
        cost -= 1  # 仁德：首次免费
    return max(1, cost)

func add_score(power: int, morale: int):
    ## 结算：兵力 × 士气
    total_score += power * morale
    print("结算：兵力 ", power, " × 士气 ", morale, " = ", power * morale, " 累计: ", total_score)
