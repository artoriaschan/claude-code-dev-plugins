# 命令模式

基于用户需求的不同命令生成模式。

## 模式 A：简单命令（无参数、无选项）

最简命令，仅有名称和描述。

**使用时机：** 用户说"添加一个名为 X 的命令"，且未提及参数或标志。

**关键元素：**
- 仅使用 Commander `.command()` 和 `.description()`
- 无 `.argument()` 或 `.option()` 调用
- Action 体：记录完成消息

## 模式 B：带参数的命令

接受位置参数的命令。

**使用时机：** 用户指定位置输入（如"接收文件路径"、"需要项目名称"）。

**关键元素：**
- 每个参数使用 `.argument('<name>', '<description>')`
- 可选参数使用 `<>` 表示必需，`[]` 表示可选
- 在 action 体中验证参数数量

## 模式 C：带选项的命令

接受命名标志/选项的命令。

**使用时机：** 用户提及标志（如"--verbose"、"--output"、"-f"、"带 dry-run 选项"）。

**关键元素：**
- `.option('<flag>, <shorthand>', '<description>')`
- 选项可通过第三个参数设置默认值
- 从 action 回调参数解析选项

## 模式 D：带参数和选项的命令

同时接受位置和命名输入。

**使用时机：** 用户同时指定参数和标志。

**关键元素：**
- `.argument()` 调用在 `.option()` 调用之前
- Action 回调先接收参数，再接收选项对象
- Zod schema 验证选项

## 模式 E：交互式命令

使用 @clack/prompts 在执行期间进行引导式输入。

**使用时机：** 用户提及"interactive"、"prompts"、"asks the user"或"wizard-style"。

**关键元素：**
- 从 `@clack/prompts` 导入 `text`、`confirm`、`select` 或 `spinner`
- 在 action 体中通过提示收集输入
- 仍然使用 Zod schema 验证收集的数据

## 模式 F：非交互式带外部输入

从 stdin、文件或环境读取输入。

**使用时机：** 用户提及"piped input"、"reads from file"、"CI-friendly"或"non-interactive"。

**关键元素：**
- 不导入 @clack/prompts
- 从 `process.stdin` 或 `fs.readFileSync` 读取
- 如果输入缺失则快速失败并给出清晰错误
