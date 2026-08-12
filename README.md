# TestGame — Godot 4.7 项目结构说明

> 像素风 2D 游戏项目，使用 [Godot 4.7](https://godotengine.org/) 引擎，素材来自 [Pixel Crawler - Free Pack](https://anokolisa.itch.io/) by Anokolisa。

---

## 目录结构总览

```
testGame/
├── project.godot                # Godot 项目配置文件（引擎核心识别文件）
├── icon.svg                     # 项目图标
├── .gitignore                   # Git 忽略规则
├── .gitattributes               # Git 文件属性（换行符 / 二进制标记）
├── README.md                    # 本文件
│
├── addons/                      # 第三方插件（当前为空）
│
├── assets/                      # 所有游戏素材资源
│   ├── Terms.txt                # 素材授权说明
│   ├── sprites/                 # 2D 精灵图片（角色 / 敌人 / NPC / 武器 / UI）
│   │   ├── characters/          # 玩家角色精灵
│   │   │   ├── body_a/          # Body_A 角色（含全套动画）
│   │   │   └── new_version/     # 新版角色（Idle / Walk）
│   │   ├── mobs/                # 敌人 / 怪物精灵
│   │   │   ├── orc_crew/        # 兽人组（Orc / Rogue / Shaman / Warrior）
│   │   │   └── skeleton_crew/   # 骷髅组（Base / Mage / Rogue / Warrior）
│   │   ├── npcs/                # NPC 精灵
│   │   │   ├── Citizen_F/       # 市民（Citizen / Peasant / Tavern_A / Tavern_B）
│   │   │   ├── Knight/          # 骑士（Idle / Run / Death）
│   │   │   ├── Rogue/           # 流浪者（Idle / Run / Death）
│   │   │   └── Wizzard/         # 巫师（Idle / Run / Death）
│   │   ├── weapons/             # 武器精灵
│   │   │   ├── Bone/            # 骨制武器
│   │   │   ├── Hands/           # 徒手
│   │   │   └── Wood/            # 木制武器
│   │   └── ui/                  # UI 相关素材
│   │       └── icons/           # UI 图标（资源图标等）
│   │
│   ├── environment/             # 环境素材
│   │   ├── props/               # 道具 / 装饰物
│   │   │   ├── animated/        # 动画道具（Pan_01~05 锅具动画）
│   │   │   └── static/          # 静态道具
│   │   │       ├── trees/       # 树木（Model_01~03，多种尺寸）
│   │   │       ├── Dungeon_Props.png     # 地牢道具图集
│   │   │       ├── Furniture.png         # 家具图集
│   │   │       ├── Rocks.png             # 岩石图集
│   │   │       ├── Vegetation.png        # 植被图集
│   │   │       ├── Shadows.png           # 阴影图集
│   │   │       ├── Tools.png             # 工具图集
│   │   │       ├── Farm.png              # 农场图集
│   │   │       ├── Meat.png              # 肉类图集
│   │   │       ├── Resources.png         # 资源图集
│   │   │       ├── Esoteric.png          # 神秘道具图集
│   │   │       └── Pan.png               # 锅具图集
│   │   │
│   │   ├── structures/          # 建筑与工作站
│   │   │   ├── buildings/       # 建筑物
│   │   │   │   ├── interior/    # 室内（墙壁 / 道具）
│   │   │   │   ├── Walls.png    # 墙壁图集
│   │   │   │   ├── Roofs.png    # 屋顶图集
│   │   │   │   ├── Shadows.png  # 建筑阴影
│   │   │   │   └── Props.png    # 建筑道具图集
│   │   │   └── stations/        # 工作站 / 制造台
│   │   │       ├── Alchemy/             # 炼金台（3 种变体）
│   │   │       ├── Anvil/               # 铁砧（3 种变体）
│   │   │       ├── Bonfire/             # 篝火（10 帧 + 火焰 + 烟雾）
│   │   │       ├── Cooking Station/     # 烹饪台（Butchery / Cooker / Grill）
│   │   │       ├── Furnace/             # 熔炉（Bricks / Iron / Stone）
│   │   │       ├── Sawmill/             # 锯木厂（4 个等级）
│   │   │       └── Workbench/           # 工作台
│   │   │
│   │   └── tilesets/            # 瓦片集（用于 TileMap 地图编辑）
│   │       ├── Dungeon_Tiles.png        # 地牢瓦片
│   │       ├── Floors_Tiles.png         # 地板瓦片
│   │       ├── Wall_Tiles.png           # 墙壁瓦片
│   │       ├── Wall_Variations.png      # 墙壁变体瓦片
│   │       ├── Water_tiles.png          # 水面瓦片
│   │       └── New_Tiles(WIP).aseprite  # 新瓦片（制作中）
│   │
│   ├── audio/                   # 音频素材（当前为空，待添加）
│   │   ├── sfx/                 # 音效
│   │   └── music/               # 背景音乐
│   │
│   ├── fonts/                   # 字体文件（当前为空，待添加）
│   └── shaders/                 # 着色器文件（当前为空，待添加）
│
├── scenes/                      # Godot 场景文件（.tscn）
│   ├── player/                  # 玩家场景
│   ├── enemies/                 # 敌人场景
│   ├── ui/                      # UI 场景（HUD / 菜单 / 对话框等）
│   └── levels/                  # 关卡 / 地图场景
│
├── scripts/                     # GDScript 脚本文件（.gd）
│   ├── player/                  # 玩家逻辑脚本
│   ├── enemies/                 # 敌人 AI 脚本
│   ├── ui/                      # UI 逻辑脚本
│   └── autoload/                # 全局单例脚本（GameManager / SaveManager 等）
│
├── resources/                   # 自定义 Resource 文件（.tres）
│                                # 如：物品数据、角色属性、配方表等
│
└── mockups/                     # 场景参考图 / 概念图
    ├── Castle_Entrance.aseprite # 城堡入口参考
    └── Tavern.png               # 酒馆参考
```

---

## 素材包分类对照表

原始素材包 `Pixel Crawler - Free Pack` 已拆分整理到以下目录：

| 原始路径 | 新路径 | 说明 |
|---|---|---|
| `Entities/Characters/Body_A/` | `assets/sprites/characters/body_a/` | 玩家角色 Body_A，含 14 套动画（Idle / Walk / Run / Attack / Death / Carry / Fish 等），每套含 Up / Down / Side 三方向 |
| `Entities/Characters/New_Version/` | `assets/sprites/characters/new_version/` | 新版角色，含 Idle 和 Walk 动画 |
| `Entities/Mobs/Orc Crew/` | `assets/sprites/mobs/orc_crew/` | 兽人敌人组：Orc / Orc-Rogue / Orc-Shaman / Orc-Warrior |
| `Entities/Mobs/Skeleton Crew/` | `assets/sprites/mobs/skeleton_crew/` | 骷髅敌人组：Base / Mage / Rogue / Warrior |
| `Entities/Npc's/` | `assets/sprites/npcs/` | NPC：Citizen_F / Knight / Rogue / Wizzard |
| `Weapons/` | `assets/sprites/weapons/` | 武器精灵：Bone / Hands / Wood |
| `Environment/Props/Animated/` | `assets/environment/props/animated/` | 动画道具（Pan_01~05 锅具动画序列帧） |
| `Environment/Props/Static/` | `assets/environment/props/static/` | 静态道具图集 + 树木模型 |
| `Environment/Structures/Buildings/` | `assets/environment/structures/buildings/` | 建筑物（墙壁 / 屋顶 / 阴影 / 道具 / 室内） |
| `Environment/Structures/Stations/` | `assets/environment/structures/stations/` | 工作站（炼金台 / 铁砧 / 篝火 / 烹饪台 / 熔炉 / 锯木厂 / 工作台） |
| `Environment/Tilesets/` | `assets/environment/tilesets/` | 瓦片集（地牢 / 地板 / 墙壁 / 水面等） |
| `Icons/` | `assets/sprites/ui/icons/` | UI 图标 |
| `MockUps/` | `mockups/` | 场景参考效果图 |
| `Terms.txt` | `assets/Terms.txt` | 素材授权条款 |

### 文件格式说明

- `.png` — 精灵图 / 图集 / 序列帧，Godot 直接导入使用
- `.aseprite` — Aseprite 源文件，需要 [Aseprite](https://www.aseprite.org/) 软件编辑。如果未安装 Aseprite，这些文件可以忽略，仅使用导出的 `.png` 即可

---

## 各目录用途详解

### `assets/` — 素材资源

所有美术、音频、字体、着色器等资源存放于此。按类型分子目录：

- **`sprites/`** — 2D 精灵图片，按实体类型分类（characters / mobs / npcs / weapons / ui）
- **`environment/`** — 环境相关素材，分为 props（道具）、structures（建筑/工作站）、tilesets（瓦片集）
- **`audio/`** — 音效（sfx）和背景音乐（music）
- **`fonts/`** — 像素字体文件（.ttf / .otf）
- **`shaders/`** — 自定义着色器（.gdshader）

### `scenes/` — 场景文件

Godot 的 `.tscn` 场景文件按功能模块分目录。每个场景是节点的组合，代表游戏中的一个功能单元（如玩家角色、敌人、UI 面板、关卡地图）。

### `scripts/` — 脚本文件

GDScript（.gd）脚本按功能模块分目录。`autoload/` 用于全局单例，在 `project.godot` 中注册后可在任何场景中直接访问。

### `resources/` — 自定义资源

存放 `.tres` 资源文件，用于数据驱动设计。例如：
- 角色属性表（HP / 攻击力 / 速度等）
- 物品数据（名称 / 图标 / 效果）
- 制作配方表

### `addons/` — 第三方插件

从 Asset Library 或 GitHub 安装的插件放在此目录。

### `mockups/` — 参考图

素材包自带的场景效果图，用于参考美术风格和关卡布局，不参与游戏运行。

---

## project.godot 配置说明

当前项目配置了适合像素风 2D 游戏的设置：

| 配置项 | 值 | 说明 |
|---|---|---|
| 渲染器 | `gl_compatibility` | 兼容性渲染，适合 2D 像素游戏，跨平台兼容性最好 |
| 视口尺寸 | 320 x 180 | 内部分辨率，经典的 16:9 像素游戏分辨率 |
| 窗口尺寸 | 1280 x 720 | 外部窗口尺寸，4x 整数缩放 |
| 拉伸模式 | `viewport` | 整个视口缩放，保持像素一致性 |
| 拉伸比例 | `keep` | 保持宽高比，不拉伸变形 |
| 纹理过滤 | Nearest（最近邻） | 像素风必备，关闭抗锯齿保持锐利像素 |

---

## 快速开始

1. **打开项目**：用 Godot 4.7 打开 `d:\Project\testGame\project.godot`
2. **首次打开**：Godot 会自动扫描并导入所有素材文件，生成 `.godot/` 缓存目录
3. **创建第一个场景**：在 `scenes/player/` 下新建场景，将 `assets/sprites/characters/body_a/` 中的动画精灵拖入
4. **配置自动加载**：如需全局单例，在 `项目 > 项目设置 > Autoload` 中注册 `scripts/autoload/` 下的脚本

---

## 素材授权

素材来自 Pixel Crawler - Free Pack by Anokolisa：
- 可用于商业项目、学习项目
- 无需署名（但署名 appreciated）
- 不可将素材本身作为最终产品出售
- 可自由修改颜色、形状、样式
- 联系作者：AnomalyPixel@gmail.com
- Patreon: https://www.patreon.com/Anokolisa

---

## 清理说明

原始素材包 `Pixel Crawler - Free Pack/` 目录仍保留在项目根目录下作为备份。确认新结构无误后，可以安全删除该目录：

```powershell
Remove-Item -Recurse -Force "d:\Project\testGame\Pixel Crawler - Free Pack"
```

> 注意：已将 `Pixel Crawler - Free Pack/` 添加到 `.gitignore`，不会被提交到版本控制。
