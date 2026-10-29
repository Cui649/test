import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../widgets/glass_action_button.dart';
import '../widgets/section_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onNavigate});

  final ValueChanged<int> onNavigate;

  static const _ip = '240e:604:36a::d8a';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 140),
      children: [
        const Text(
          'IP TEST',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '当前网络、归属查询与 DNS 解析。',
          style: TextStyle(
            fontSize: 14,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
        const SizedBox(height: 22),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    CupertinoIcons.wifi,
                    size: 18,
                    color: Color(0xFF1A7F37),
                  ),
                  SizedBox(width: 6),
                  Text(
                    '当前 IPv6',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A7F37),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                _ip,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                '中国 北京市 海淀区 · 中国联通',
                style: TextStyle(
                  fontSize: 13,
                  color: CupertinoColors.secondaryLabel,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GlassActionButton(
                label: '复制 IP',
                onTap: () {
                  Clipboard.setData(const ClipboardData(text: _ip));
                  GlassToast.show(
                    context,
                    message: 'IP 已复制',
                    type: GlassToastType.success,
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GlassActionButton(
                label: '刷新检测',
                onTap: () => GlassToast.show(
                  context,
                  message: '当前为演示数据，接入 API 后刷新真实地址。',
                  type: GlassToastType.info,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        const SectionTitle('快捷入口'),
        SectionCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _HomeTile(
                icon: CupertinoIcons.search,
                title: 'IP 归属查询',
                subtitle: '市级归属、运营商与 ASN',
                onTap: () => onNavigate(1),
              ),
              const Divider(height: 1, indent: 52),
              _HomeTile(
                icon: CupertinoIcons.globe,
                title: 'DNS 查询',
                subtitle: 'A / AAAA / CNAME 与解析 IP',
                onTap: () => onNavigate(2),
              ),
              const Divider(height: 1, indent: 52),
              _HomeTile(
                icon: CupertinoIcons.person_crop_circle,
                title: '账户与额度',
                subtitle: '会员卡、查询额度与设置',
                onTap: () => onNavigate(3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'DNS 解析 IP 可能是 CDN / 负载均衡节点，不代表网站源站。',
          style: TextStyle(
            fontSize: 11.5,
            height: 1.6,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
      ],
    );
  }
}

class _HomeTile extends StatelessWidget {
  const _HomeTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: const Color(0xFF0071E3)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.label,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              size: 16,
              color: CupertinoColors.tertiaryLabel,
            ),
          ],
        ),
      ),
    );
  }
}
