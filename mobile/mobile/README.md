# IP TEST Mobile

独立 Flutter 移动端骨架，不改动现有 Flask Web 与管理后台。

## 当前范围

- `GlassScaffold` + `GlassAppBar` + `GlassTabBar.bottom` 导航
- `GlassTextField` 输入
- `GlassModalSheet` 登录弹窗
- `GlassToast` 轻提示
- 实色内容卡片，玻璃只用于导航、输入和弹层
- 首页、IP 查询、DNS 查询、我的四个演示页面

当前使用 mock 数据，尚未接入 `/api/v1`。

## 环境

- Flutter `>= 3.41.0`
- Dart `>= 3.5.0`
- `liquid_glass_widgets: 1.16.0`

## 首次生成平台目录

仓库只包含 Dart 源码和 `pubspec.yaml`，还没有 Android/iOS 平台目录。首次使用时执行：

```bash
cd mobile
flutter create --platforms=android,ios --project-name ip_test_mobile .
flutter pub get
```

如果平台目录已经存在，只需要：

```bash
flutter pub get
```

## 运行

```bash
flutter run
```

iOS 构建需要 macOS + Xcode；Linux 服务器只能构建 Android APK 或 Flutter Web。

## 后续接入

建议按以下顺序补 API：

1. `/api/v1/auth/login`
2. `/api/v1/me`
3. `/api/v1/ip`
4. `/api/v1/dns`
5. `/api/v1/membership`
6. `/api/v1/messages`

在 API 完成前，页面中的 IP、DNS、账户数据均为演示数据。

## 说明

- `liquid_glass_widgets` 要求 Flutter 3.41+。
- 列表和内容卡片使用 `GlassSurfaceStyle.solid`，不要把玻璃控件嵌套在玻璃容器中。
- 真实设备上需要验证 Impeller 渲染、滚动帧率和 Android GLES 回退表现。
