import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../widgets/glass_action_button.dart';
import '../widgets/section_card.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _signedIn = false;

  Future<void> _openLogin() async {
    await GlassModalSheet.show(
      context: context,
      builder: (sheetContext) => _LoginSheet(
        sheetContext: sheetContext,
        rootContext: context,
        onSignedIn: () {
          if (mounted) {
            setState(() => _signedIn = true);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 140),
      children: [
        const Text(
          '我的',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        const Text(
          '会员卡、额度与账户设置。',
          style: TextStyle(
            fontSize: 13,
            color: CupertinoColors.secondaryLabel,
          ),
        ),
        const SizedBox(height: 20),
        _MemberCard(signedIn: _signedIn),
        const SizedBox(height: 14),
        SectionCard(
          child: Column(
            children: [
              InfoRow(
                label: '状态',
                value: _signedIn ? '已登录' : '未登录',
              ),
              InfoRow(label: '查询额度', value: _signedIn ? '10 次' : '—'),
              InfoRow(label: 'API 额度', value: _signedIn ? '0 次' : '—'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        if (!_signedIn)
          GlassActionButton(label: '登录账户', onTap: _openLogin)
        else
          GlassActionButton(
            label: '退出登录',
            onTap: () {
              setState(() => _signedIn = false);
              GlassToast.show(
                context,
                message: '已退出当前演示账户。',
                type: GlassToastType.info,
              );
            },
          ),
        const SizedBox(height: 14),
        const Text(
          '当前为演示账户；接入 /api/v1 后读取真实账号、额度和会员卡。',
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

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.signedIn});

  final bool signedIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF7CD6B), Color(0xFFD7952A)],
        ),
        border: Border.all(color: const Color(0x99FFFFFF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33212B3A),
            blurRadius: 34,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                '金卡',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF20242C),
                ),
              ),
              Spacer(),
              Text(
                'IP TEST',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF20242C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'GOLD',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
              color: Color(0xCC20242C),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            signedIn ? 'NO. 7000000002' : '登录后显示会员卡号',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
              color: Color(0xFF20242C),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '成长积分',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xCC20242C),
                    ),
                  ),
                  Text(
                    signedIn ? '120' : '—',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF20242C),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                '演示账户',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xCC20242C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LoginSheet extends StatefulWidget {
  const _LoginSheet({
    required this.sheetContext,
    required this.rootContext,
    required this.onSignedIn,
  });

  final BuildContext sheetContext;
  final BuildContext rootContext;
  final VoidCallback onSignedIn;

  @override
  State<_LoginSheet> createState() => _LoginSheetState();
}

class _LoginSheetState extends State<_LoginSheet> {
  String _email = '';
  String _password = '';

  void _submit() {
    if (_email.trim().isEmpty || _password.isEmpty) {
      GlassToast.show(
        widget.rootContext,
        message: '请填写邮箱和密码。',
        type: GlassToastType.error,
      );
      return;
    }
    Navigator.of(widget.sheetContext).pop();
    widget.onSignedIn();
    GlassToast.show(
      widget.rootContext,
      message: '登录成功。',
      type: GlassToastType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '登录账户',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          const Text(
            '演示登录；接入 API 后使用真实账号。',
            style: TextStyle(
              fontSize: 12,
              color: CupertinoColors.secondaryLabel,
            ),
          ),
          const SizedBox(height: 18),
          GlassTextField(
            surfaceStyle: GlassSurfaceStyle.solid,
            placeholder: '邮箱',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (value) => _email = value,
          ),
          const SizedBox(height: 10),
          GlassTextField(
            surfaceStyle: GlassSurfaceStyle.solid,
            placeholder: '密码',
            obscureText: true,
            textInputAction: TextInputAction.done,
            onChanged: (value) => _password = value,
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 18),
          CupertinoButton.filled(
            onPressed: _submit,
            child: const Text('登录'),
          ),
        ],
      ),
    );
  }
}
