import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../widgets/glass_action_button.dart';
import '../widgets/section_card.dart';

class DnsScreen extends StatefulWidget {
  const DnsScreen({super.key});

  @override
  State<DnsScreen> createState() => _DnsScreenState();
}

class _DnsScreenState extends State<DnsScreen> {
  final _controller = TextEditingController();
  String? _domain;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _validDomain(String value) {
    if (value.isEmpty || value.length > 253) {
      return false;
    }
    if (value.contains('://') ||
        value.contains(':') ||
        value.contains('/') ||
        value.contains('@') ||
        value.contains('[') ||
        value.contains(']')) {
      return false;
    }
    if (RegExp(r'^\d{1,3}(\.\d{1,3}){3}$').hasMatch(value)) {
      return false;
    }
    return value.contains('.') && !value.startsWith('.') && !value.endsWith('.');
  }

  void _submit() {
    final value = _controller.text.trim();
    if (!_validDomain(value)) {
      setState(() {
        _domain = null;
        _error = '请输入域名，不能直接输入 IPv4/IPv6、URL、端口或路径。';
      });
      GlassToast.show(
        context,
        message: '域名格式不正确。',
        type: GlassToastType.error,
      );
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _domain = value;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 140),
      children: [
        const Text(
          'DNS 查询',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        const Text(
          'DNS 解析 IP（可能是 CDN / 负载均衡节点，不代表网站源站）。',
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
        const SizedBox(height: 20),
        GlassTextField(
          controller: _controller,
          useOwnLayer: true,
          placeholder: '例如 example.com',
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _submit(),
          prefixIcon: const Icon(
            CupertinoIcons.globe,
            size: 18,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
        const SizedBox(height: 12),
        GlassActionButton(label: 'DNS 查询', onTap: _submit),
        if (_error != null) ...[
          const SizedBox(height: 12),
          Text(
            _error!,
            style: const TextStyle(
              fontSize: 12.5,
              color: CupertinoColors.systemRed,
            ),
          ),
        ],
        if (_domain != null) ...[
          const SizedBox(height: 28),
          const SectionTitle('DNS 记录'),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _domain!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                const InfoRow(label: 'A', value: '104.20.23.154'),
                const InfoRow(label: 'AAAA', value: '2606:4700:10::6814:179a'),
                const InfoRow(label: 'CNAME', value: 'edge.example.com'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const SectionTitle('解析 IP 归属'),
          const SectionCard(
            child: Column(
              children: [
                InfoRow(label: 'IP', value: '104.20.23.154'),
                InfoRow(label: '市级归属', value: '美国 加利福尼亚州 旧金山'),
                InfoRow(label: '组织/运营商', value: 'Cloudflare, Inc.'),
                InfoRow(label: 'ASN', value: 'AS13335'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '当前为演示结果；接入 /api/dns 后显示真实解析记录与 IP 库归属。',
            style: TextStyle(
              fontSize: 11.5,
              height: 1.6,
              color: CupertinoColors.secondaryLabel,
            ),
          ),
        ],
      ],
    );
  }
}
