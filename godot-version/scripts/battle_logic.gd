extends RefCounted
## 战斗结算逻辑

static func detect_hand_type(cards: Array) -> String:
    ## 检测牌型
    var ranks = []
    var suits = []
    for c in cards:
        ranks.append(c.rank)
        suits.append(c.suit)
    ranks.sort()

    # 同花
    var is_flush = true
    for s in suits:
        if s != suits[0]:
            is_flush = false
            break

    # 顺子
    var is_straight = true
    for i in range(1, ranks.size()):
        if ranks[i] != ranks[i-1] + 1:
            is_straight = false
            break

    # 统计点数
    var rank_counts = {}
    for r in ranks:
        rank_counts[r] = rank_counts.get(r, 0) + 1

    var count_values = rank_counts.values()
    count_values.sort()

    if is_flush and is_straight:
        if ranks[0] == 1 and ranks[4] == 13:
            return "royal_flush"  # 皇家同花顺
        return "straight_flush"  # 同花顺
    elif count_values == [1, 1, 1, 1, 1]:
        if is_flush:
            return "flush"  # 同花
        if is_straight:
            return "straight"  # 顺子
        return "high_card"  # 高牌
    elif count_values == [1, 4]:
        return "four_kind"  # 四条
    elif count_values == [2, 3]:
        return "full_house"  # 葫芦
    elif count_values == [1, 1, 3]:
        return "three_kind"  # 三条
    elif count_values == [1, 2, 2]:
        return "two_pair"  # 两对
    elif count_values == [1, 1, 1, 2]:
        return "pair"  # 一对
    return "high_card"

static func calculate_score(cards: Array, hand_type: String, game_data: Dictionary) -> Dictionary:
    ## 计算分数
    var hand_table = game_data.hand_types
    var hand_info = hand_table[hand_type]

    var base_power = hand_info.base_power
    var base_morale = hand_info.base_morale

    # 计算打出的牌面兵力
    var card_power = 0
    for c in cards:
        card_power += c.get_power()

    # 总兵力 = 基础兵力 + 牌面兵力
    var total_power = base_power + card_power

    # 士气
    var total_morale = base_morale

    # 应用武将效果（简化版）
    # TODO: 接入武将技能

    # 最终分数 = 兵力 × 士气
    var final_score = total_power * total_morale

    return {
        "hand_type": hand_type,
        "hand_name": hand_info.name,
        "base_power": base_power,
        "card_power": card_power,
        "total_power": total_power,
        "total_morale": total_morale,
        "final_score": final_score
    }
