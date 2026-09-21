extends RefCounted
## 扑克牌类

var suit: String = ""    # 花色：spade/heart/club/diamond
var rank: int = 0        # 点数：1-13（1=A, 11=J, 12=Q, 13=K）
var is_face: bool = false # 是否人头牌（J/Q/K）
var is_red: bool = false # 是否红牌（红桃/方块）
var is_black: bool = false # 是否黑牌（黑桃/梅花）
var enhancement: String = "" # 增强：bonus(加成)/multiplier(倍数)/steel(钢牌)

func _init(s: String, r: int):
    suit = s
    rank = r
    is_face = (r >= 11 and r <= 13)
    is_red = (s == "heart" or s == "diamond")
    is_black = (s == "spade" or s == "club")

func get_power() -> int:
    ## 牌面兵力：A=11，人头=10，其他=点数
    if rank == 1:
        return 11
    elif is_face:
        return 10
    else:
        return rank

func get_display_name() -> String:
    var suit_names = { "spade": "♠", "heart": "♥", "club": "♣", "diamond": "♦" }
    var rank_names = { 1: "A", 11: "J", 12: "Q", 13: "K" }
    var rn = rank_names.get(rank, str(rank))
    return suit_names[suit] + rn

static func create_deck() -> Array:
    ## 创建一副 52 张牌
    var deck = []
    var suits = ["spade", "heart", "club", "diamond"]
    for s in suits:
        for r in range(1, 14):
            deck.append(Card.new(s, r))
    return deck
