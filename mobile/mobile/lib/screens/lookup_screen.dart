import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../widgets/glass_action_button.dart';
import '../widgets/section_card.dart';

class LookupScreen extends StatefulWidget {
  const LookupScreen({super.key});

  @override
  State<LookupScreen> createState() => _LookupScreenState();
}

class _LookupScreenState extends State<LookupScreen> {
  final _controller = TextEditingController();
  bool _hasResult = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = _controller.text.trim();
    if (value.isEmpty) {
      GlassToast.show(
        context,
        message: '请输入要查询的 IP。',
        type: GlassToastType.error,
      );
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() => _hasResult = true);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 140),
      children: [
        const Text(
          'IP 归属查询',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        const Text(
          '输入 IPv4 或 IPv6，查看市级归属、运营商与 ASN。',
          style: TextStyle(
            fontSize: 13,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
        const SizedBox(height: 20),
        GlassTextField(
          controller: _controller,
          useOwnLayer: true,
          placeholder: '例如 8.8.8.8 或 240e::1',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _submit(),
          prefixIcon: const Icon(
            CupertinoIcons.search,
            size: 18,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
        const SizedBox(height: 12),
        GlassActionButton(label: '查询', onTap: _submit),
        if (_hasResult) ...[
          const SizedBox(height: 28),
          const SectionTitle('查询结果'),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '8.8.8.8',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F7ED),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        'IPv4',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A7F37),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const InfoRow(label: '市级归属', value: '美国 加利福尼亚州 山景城'),
                const InfoRow(label: '运营商', value: 'Google LLC'),
                const InfoRow(label: 'ASN', value: 'AS15169'),
                const InfoRow(label: 'AS 名称', value: 'Google LLC'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '当前为演示结果；接入 /api/v1 后显示真实 IP 库数据。',
            style: TextStyle(
              fontSize: 11.5,
              color: CupertinoColors.secondaryLabel,
            ),
          ),
        ],
      ],
    );
  }
}
