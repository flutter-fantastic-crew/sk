import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddHistoryPage extends StatefulWidget {
  const AddHistoryPage({super.key});

  @override
  State<AddHistoryPage> createState() => _AddHistoryPageState();
}

class _AddHistoryPageState extends State<AddHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 14,
          ),
          onPressed: () {
            context.pop();
            // 바로가기 버튼이 눌렸을 때의 동작
          },
        ),
        title: const Column(
          children: [
            Text(
              '내역 추가', // 첫 번째 줄 텍스트
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              '계획 제목', // 두 번째 줄 텍스트
              style: TextStyle(
                fontSize: 10,
                color: Colors.black38,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double?>(0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xffEEEEEE),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      minimumSize:
                          MaterialStateProperty.all<Size?>(const Size(60, 60))
                      // fixedSize: MaterialStateProperty.all<Size?>(const Size(20, 20)),
                      ),
                  onPressed: () => {},
                  child: const Text(
                    '-',
                    style: TextStyle(
                      color: Color(0XFF40BE40),
                      fontSize: 40,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: '소비 금액',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
