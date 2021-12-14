import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:secman_parking/common/widgets/stateless/app_drawer.dart';
import 'package:secman_parking/themes/app_themes.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: _buildBackgroundColor(_index),
          iconTheme: AppThemes.iconThemeAppBar,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: _onTap,
              icon: const Icon(Icons.ac_unit),
            ),
          ],
        ),
        backgroundColor: _buildBackgroundColor(_index),
        drawer: const AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Builder(builder: (context) {
            if (_index == 1) {
              return const InfoCard(
                isIn: true,
                isGuest: false,
              );
            }
            if (_index == 2) {
              return const InfoCard(
                isIn: false,
                isGuest: true,
                urlImage:
                    'https://cartimes.vn/images/20/9/17/bien_so_xe_ha_nam_1.jpg',
              );
            }
            return const Center(
              child: AutoSizeText(
                'Quét mã...',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 100,
                ),
              ),
            );
          }),
        ));
  }

  Color _buildBackgroundColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.redAccent;
    }
    return Colors.blue;
  }

  void _onTap() {
    if (_index == 2) {
      setState(() {
        _index = 0;
      });
    } else {
      setState(() {
        _index++;
      });
    }
  }
}

class InfoCard extends StatelessWidget {
  final bool isIn;
  final bool isGuest;
  final String? urlImage;

  const InfoCard({
    Key? key,
    required this.isIn,
    required this.isGuest,
    this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: isGuest
                ? urlImage != null
                    ? CachedNetworkImage(
                        imageUrl: urlImage!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 3, color: Colors.white)),
                          child: const AutoSizeText(
                            'Không tải được ảnh',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.white)),
                        child: const AutoSizeText(
                          'Không tìm thấy ảnh',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                : const AutoSizeText(
                    '123.45',
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 100,
                    ),
                  ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AutoSizeText(
                'Mã thẻ ...........',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                ),
              ),
              AutoSizeText(
                isGuest ? 'Khách vãng lai' : 'Người tòa nhà',
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const AutoSizeText(
                '20:30 14/12/2021',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 40),
              Icon(
                isIn ? Icons.arrow_downward : Icons.arrow_upward,
                size: 150,
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    );
  }
}
