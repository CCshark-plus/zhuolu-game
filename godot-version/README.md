# 三国逐鹿 · Godot 移植规划

## 现状
- HTML 版原型（deck.html）：第 36 步，核心玩法已跑通
- Godot 4.3 已装：`D:\tools\godot\Godot_v4.3-stable_win64.exe`
- 项目目录：`D:\projects\zhuolu-godot`

## 为什么转 Godot
- 你要的是"游戏"，不是网页
- Godot 能导出 Windows .exe / Mac / Android，可直接发给别人下载
- 单文件 HTML 只是原型，最终要用游戏引擎

## 项目结构
```
zhuolu-godot/
├── project.godot          # Godot 项目配置
├── scenes/                # 场景文件（.tscn）
│   ├── main.tscn          # 主场景（根）
│   ├── main_menu.tscn     # 主菜单
│   ├── battle.tscn       # 战斗界面
│   ├── shop.tscn         # 商店
│   ├── map.tscn          # 城池地图
│   └── codex.tscn        # 武将图鉴
├── scripts/               # GDScript 脚本
│   ├── game_state.gd     # 全局游戏状态（单例）
│   ├── card.gd           # 扑克牌
│   ├── general.gd        # 武将
│   ├── battle_logic.gd   # 战斗结算
│   └── shop_logic.gd     # 商店
├── assets/                # 美术/音频
│   ├── sprites/          # 像素小人
│   ├── ui/               # UI 图
│   └── audio/            # 音效
└── data/                  # 数值表（JSON）
    ├── generals.json     # 武将表
    ├── poker_hands.json  # 牌型表
    └── city_curve.json   # 城池难度曲线
```

## 移植优先级（第一步先做什么）
1. **主菜单**：打开游戏 → 开始按钮 → 进入战斗
2. **战斗核心循环**：发牌 → 选牌 → 出牌 → 算分 → 过关 → 进商店
3. **商店**：买武将 → 刷新 → 下一关
4. **八城八关**：难度曲线
5. **武将技能/羁绊**
6. **音效/动画**

## 零基础学习路径（Godot + GDScript）
- GDScript 语法接近 Python，比 JS 简单
- 先学会：节点（Node）、场景（Scene）、信号（Signal）三个概念
- 跟着 deck.html 已有逻辑照搬，不用重新设计

## 第一步：打开 Godot 编辑器
1. 双击 `D:\tools\godot\Godot_v4.3-stable_win64.exe`
2. 点"导入"
3. 选择 `D:\projects\zhuolu-godot\project.godot`
4. 点"导入并编辑"
5. 打开后告诉我，我带你建第一个场景
