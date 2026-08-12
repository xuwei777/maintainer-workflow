# Maintainer Workflow

> **让你的编码 Agent 像维护者一样完成整个仓库任务，而不只是写几段代码。**

[![Agent Skill](https://img.shields.io/badge/Agent%20Skill-portable-111111?style=flat-square)](https://agentskills.io/)
[![Install with skills](https://img.shields.io/badge/install%20with-skills-111111?style=flat-square)](https://github.com/vercel-labs/skills)
[![License: MIT](https://img.shields.io/badge/license-MIT-111111?style=flat-square)](LICENSE)
[![English](https://img.shields.io/badge/docs-English-111111?style=flat-square)](README.md)
[![简体中文](https://img.shields.io/badge/文档-简体中文-111111?style=flat-square)](README.zh-CN.md)

这是一个可移植的 Agent Skill：它让编码工作待在正确分支和授权范围内，并通过可选、
可独立验收的工作包持续推进到真实验收。它遵循 Agent Skills 格式，可通过 `skills`
CLI 安装到 Codex、Claude Code、Cursor、Qoder 以及其他支持 Skill 的编码 Agent。

**有意保持精简，只在真正重要的地方严格。** 整个包只有一个可移植 Skill、一个只读
预检脚本和两份可选模板，不引入框架、常驻服务、Bot 或项目管理运行时。

## 一条命令安装

```shell
npx skills add xuwei777/maintainer-workflow --skill maintainer-workflow -g
```

新开一个 Agent 会话，然后告诉它：

```text
使用 $maintainer-workflow 检查并继续当前仓库任务。
```

### 给负责安装或更新的 Agent

用户已经明确要求安装、更新或重新安装本 Skill 时，直接使用官方非交互命令执行。不要再
围绕 `npx` 还是 Git、是否复制仓库文件、是否允许覆盖托管安装连续提问。

```shell
npx -y skills@latest add xuwei777/maintainer-workflow --skill maintainer-workflow -g --yes
```

目标 Agent 已知时增加 `--agent <agent-id>`。只有实际检查证明覆盖托管 Skill 目录会
丢失用户手工修改，或者无法安全确定目标 Agent 或安装范围时，才暂停询问。

安装目录有意只包含 `skills/maintainer-workflow/` 下的内容。仓库根目录的
`README.md`、`AGENTS.md`、`LICENSE`、`CONTRIBUTING.md`、`SECURITY.md` 和
`scripts/check.ps1` 属于仓库说明及维护文件；安装目录没有这些文件是正常结果，不代表
安装不完整。

## 为什么值得安装？

编码 Agent 通常不是不会写代码，而是从过期状态开工、把有趣的代码缺口当成当前目标、
不断扩大范围、过度相信 Mock 测试，或者在真实流程尚未验证时宣布完成。

Maintainer Workflow 会改变这些默认行为：

| 没有这个 Skill | 使用 Maintainer Workflow |
| --- | --- |
| 相信当前目录或旧交接文档 | 先对齐实时 Git、工作项、评审请求和运行状态 |
| 从显眼的代码缺口里挑任务 | 从当前目标和未满足的退出门推导下一切片 |
| 把一个功能拆成通用开发清单 | 只在有价值时使用可独立交付的工作包 |
| 把绿测试当成交付完成 | 区分静态、Mock、合成、隔离实机和线上证据 |
| 目标完成后继续顺手优化 | 达到退出条件后停止，并回到记录的主线 |
| 自行推断可以合并或部署 | Ready、合并、发布、部署和线上操作重新确认 |

它让 Agent 像一个需要对本次任务结束后的仓库负责的维护者，而不是只追求“看起来已经
完成”的代码生成器。

## 它如何工作

```text
定向  →  定界  →  执行  →  验证  →  交接
```

| 步骤 | 维护者行为 |
| --- | --- |
| **定向** | 确认真实仓库、分支、HEAD、上游、未提交改动、当前任务和可用环境 |
| **定界** | 锁定可观察结果、非目标、接口、权限、风险和停止条件 |
| **执行** | 通过仓库现有职责边界完成最小合格切片 |
| **验证** | 让证据等级匹配风险；环境可用时实际执行用户或运维流程 |
| **交接** | 报告已审 HEAD、检查结果、`NOT_RUN` 项、剩余风险和唯一最安全下一步 |

## 工作包怎么用

一个父工作项可以负责一个较大的完整能力。只有真实的产品行为、架构边界、迁移、研究
问题或运维结果需要独立验收时，才拆成 WP。

```text
父工作项目标：用户可以安全导入 CSV

WP1  预览解析结果并解释无效记录
WP2  确认后幂等写入，重复提交不产生重复数据
WP3  下载失败记录，并只重试这些记录
```

每个 WP 都带自己的成功、失败、恢复和真实验收证据。不单独制造“测试 WP”，也不强制
套用 `基础 → 核心 → 文档` 流水线；简单任务完全不需要 WP 标签。

只有用户已经授权精确的 WP 序列，而且下一个进入门仍然成立时，Agent 才能不反复询问
而继续推进。如果前一 WP 的证据推翻了后续前提，它必须停止或重新规划，不能机械完成旧
待办。

## 三种工作模式

| 模式 | 适用场景 | Agent 的默认行为 |
| --- | --- | --- |
| **Bootstrap** | 仓库缺少有效治理规则 | 检查技术栈，提出最小规则和验收命令，获得授权后再写入 |
| **Adopt** | 项目已经开发一部分，但状态混乱 | 对齐 Git 和事实源，恢复主线及当前工作，发现冲突就报告而不是猜测 |
| **Deliver** | 当前工作项和权限已经明确 | 将最小合格切片推进到实现、自动检查、真实验收、评审和准确交接 |

## 它会约束什么

- 修改前核对真实仓库状态；
- 维护唯一当前主线、受限临时轨道和明确返回目标；
- 明确可观察结果、非目标、锁定接口和风险等级；
- 保留用户的无关改动；
- 由确定性策略而不是模型输出决定副作用权限；
- 子 Agent 只承担边界明确的任务，主 Agent 必须复审；
- 发布前扫描完整提交范围中的隐私内容；
- 环境可用时，主动完成用户可见功能的真实或人工验收；
- 交接时给出精确命令、已审 HEAD、`NOT_RUN` 项、风险和唯一最安全下一步。

## 它不会擅自做什么

安装 Skill 不会自动创建 `AGENTS.md`、roadmap、Issue、分支、钩子、Bot、服务、提交或
Pull Request，也不会自行合并、发布、部署或执行破坏性清理。

仓库没有规则时，它会根据
[`AGENTS.md` 模板](skills/maintainer-workflow/assets/AGENTS.template.md)
提出一份精简的项目配置，并等待仓库写入授权。它是可移植的工作指令，不是项目管理框架
或安全沙盒。

## 其他安装方式

全局安装：

```shell
npx skills add xuwei777/maintainer-workflow --skill maintainer-workflow -g
```

无交互更新或重新安装全局托管副本：

```shell
npx -y skills@latest add xuwei777/maintainer-workflow --skill maintainer-workflow -g --yes
```

只安装到当前项目：

```shell
npx skills add xuwei777/maintainer-workflow --skill maintainer-workflow
```

只查看、不安装：

```shell
npx skills add xuwei777/maintainer-workflow --list
```

也可以使用完整 Git 地址：

```shell
npx skills add https://github.com/xuwei777/maintainer-workflow.git --skill maintainer-workflow -g
```

[`skills` CLI](https://github.com/vercel-labs/skills) 需要 Node.js 18 或更高版本，安装时
会选择目标 Agent。不支持 Skill 的 Agent 仍可直接读取
[`SKILL.md`](skills/maintainer-workflow/SKILL.md)，并手动采用仓库内模板。

## 常见问题

**它会强制每个任务都创建 Issue 或 WP 吗？**

不会。正式 WP 是可选的。简单任务保持简单；只有独立验收能改善顺序或验证时，较大工作
才需要切片。

**它会创建或替换我的 `AGENTS.md` 吗？**

不会。仓库自己的规则优先于通用 Skill。缺少有效治理时，它只会提出一份精简项目配置，
得到授权后才写入。

**它会替代 CI、测试或项目文档吗？**

不会。CI 和测试提供证据，项目文档负责项目事实。Skill 负责 Agent 如何读取事实、选择
工作、让证据匹配风险，并准确报告尚未验证的内容。

**它会拖慢小修复吗？**

不会机械加流程。小型本地修改不需要虚构 roadmap、正式 WP 序列或生产级仪式。

**它只能用于 Codex 吗？**

不是。它遵循可移植的 Agent Skills 格式，并通过跨 Agent 的 `skills` CLI 分发；具体宿主
行为仍取决于目标 Agent 的 Skill 支持。

## 仓库内容

```text
skills/maintainer-workflow/
├── SKILL.md                         # Agent 工作流
├── agents/openai.yaml               # Skill 界面元数据
├── assets/AGENTS.template.md        # 精简项目配置模板
├── assets/work-package.template.md  # 父工作项与可选 WP 契约
├── references/project-profiles.md   # 项目类型和权限映射
└── scripts/preflight.ps1            # Windows Git 只读预检
```

## 本地验证

```powershell
pwsh -File scripts/check.ps1
npx -y skills@latest add . --list
git diff --check
```

贡献规则见 [CONTRIBUTING.md](CONTRIBUTING.md)，安全报告方式见
[SECURITY.md](SECURITY.md)，许可证为 [MIT](LICENSE)。
