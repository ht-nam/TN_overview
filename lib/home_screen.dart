import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:video_player/video_player.dart';
import 'district_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:html' as html;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _ctrlPressed = false;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final messageController = TextEditingController();
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  late VideoPlayerController _videoController;

  final List<Map> imageDataList = [
    {
      'image':
          'https://images.vietnamtourism.gov.vn/vn//images/2019/doi-che-tan-cuong-2-1.jpg',
      'title': 'Đồi chè Tân Cương',
      'description': 'Khám phá những đồi chè bạt ngàn tại Thái Nguyên.',
      'url': 'https://maps.app.goo.gl/tR3c9scqDby3tmGW9'
    },
    {
      'image': 'https://sinhtour.vn/wp-content/uploads/2024/07/ho-nui-coc.jpg',
      'title': 'Hồ Núi Cốc',
      'description': 'Điểm đến du lịch sinh thái nổi tiếng.',
      'url': 'https://maps.app.goo.gl/fsM7djK1yCXuQkKv8',
    },
    {
      'image':
          'https://bvhttdl.mediacdn.vn/291773308735864832/2023/4/28/fbc84adbcff810a649e9-1682670216807401299002.jpg',
      'title': 'Bảo tàng các dân tộc Việt Nam',
      'description': 'Nơi lưu giữ bản sắc văn hóa dân tộc.',
      'url': 'https://maps.app.goo.gl/XffFht99KKwhVM5u6',
    },
    {
      'image':
          'https://bvhttdl.mediacdn.vn/291773308735864832/2022/9/13/img1892-1636508813005-16365088220081764330763-1663034153291-16630341538451650438904.jpg',
      'title': 'Di tích quốc gia đặc biệt ATK Định Hoá',
      'description': 'Khu căn cứ cách mạng quan trọng thời kháng chiến.',
      'url': 'https://maps.app.goo.gl/h8BCSCJgFgYHQ3it7',
    },
    {
      'image':
          'https://hnm.1cdn.vn/2020/02/14/hanoimoi.com.vn-uploads-images-tuandiep-2020-02-14-_den_duom-01-.jpg',
      'title': 'Đền Đuổm',
      'description': 'Ngôi đền thờ danh tướng Dương Tự Minh.',
      'url': 'https://maps.app.goo.gl/qGUatiwtLzJvJdFQ8',
    },
    {
      'image':
          'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2023/3/18/1159235/Lang-Thai-Hai-Nha-Sa.jpg',
      'title': 'Khu bảo tồn làng nhà sàn dân tộc sinh thái Thái Hải',
      'description': 'Bảo tồn văn hóa Tày – Nùng trong không gian sinh thái.',
      'url': 'https://maps.app.goo.gl/3EYMEzHa43MwNeCR9',
    },
    {
      'image':
          'https://r2.nucuoimekong.com/wp-content/uploads/ngoi-chua-noi-tieng-mien-tay.jpg',
      'title': 'Chùa Hang',
      'description':
          'Ngôi chùa nổi tiếng linh thiêng và độc đáo trong hang đá.',
      'url': 'https://maps.app.goo.gl/BcVxDV4ysknqpUox9',
    },
  ];

  final List<Map<String, dynamic>> items = const [
    {
      'title': '1. Hỗ trợ an ninh',
      'content': '''
        <h2>📞 Liên hệ khi cần hỗ trợ an ninh</h2>
<p>Khi cần hỗ trợ về an ninh tại các khu vui chơi ở Thái Nguyên, bạn có thể liên hệ với:</p>

<h3>Công an tỉnh Thái Nguyên:</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Số 17, đường Cách mạng Tháng 8, TP. Thái Nguyên.</li>
  <li><strong>Trực ban:</strong> 069.2666.109</li>
  <li><strong>Cảnh sát phản ứng nhanh:</strong> 113</li>
</ul>

<h3>Phòng Cảnh sát giao thông, Công an tỉnh Thái Nguyên:</h3>
<ul>
  <li><strong>Số điện thoại trực ban:</strong> 0208.3656.122</li>
</ul>

<h3>Đường dây nóng phản ánh tiêu cực, tham nhũng:</h3>
<ul>
  <li><strong>Bộ Công an:</strong> 069.2342.593</li>
  <li><strong>Công an tỉnh Thái Nguyên:</strong> 069.2669.114</li>
</ul>

<h3>Công an các phường, xã nơi có khu vui chơi:</h3>
<ol>
  <li>
    <strong>Công an phường Tân Thành</strong><br>
    <em>Địa chỉ:</em> Phường Tân Thành, TP. Thái Nguyên<br>
    <em>Số điện thoại:</em> 0208 3847 637
  </li>
  <li>
    <strong>Công an phường Quán Triều</strong><br>
    <em>Địa chỉ:</em> 606 Dương Tự Minh, Quán Triều, TP. Thái Nguyên<br>
    <em>Số điện thoại:</em> 0208 3844 063
  </li>
  <li>
    <strong>Công an phường Đồng Quang</strong><br>
    <em>Địa chỉ:</em> Đường Hoàng Văn Thụ, Đồng Quang, TP. Thái Nguyên<br>
    <em>Số điện thoại:</em> 0208 3765 029
  </li>
  <li>
    <strong>Công an phường Trưng Vương</strong><br>
    <em>Địa chỉ:</em> 54 Bến Tượng, Trưng Vương, TP. Thái Nguyên<br>
    <em>Số điện thoại:</em> 0208 3854 409
  </li>
  <li>
    <strong>Công an phường Gia Sàng</strong><br>
    <em>Địa chỉ:</em> Gia Sàng, TP. Thái Nguyên<br>
    <em>Số điện thoại:</em> 0208 3855 579
  </li>
  <li>
    <strong>Công an phường Đồng Tiến (Phổ Yên)</strong><br>
    <em>Địa chỉ:</em> Phường Đồng Tiến, TX. Phổ Yên<br>
    <em>Số điện thoại:</em> 0208 857 767
  </li>
  <li>
    <strong>Công an phường Cải Đan (Sông Công)</strong><br>
    <em>Địa chỉ:</em> Phường Cải Đan, TP. Sông Công<br>
    <em>Số điện thoại:</em> 0208 3860 203
  </li>
  <li>
    <strong>Công an phường Hương Sơn</strong><br>
    <em>Địa chỉ:</em> Hương Sơn, TP. Thái Nguyên<br>
    <em>Số điện thoại:</em> 0208 3832 273
  </li>
</ol>
'''
    },
    {
      'title': '2. Hỗ trợ y tế',
      'content': '''
<h2>🏥 Bệnh viện lớn</h2>

<h3>Bệnh viện Đa khoa Trung tâm Thái Nguyên</h3>
<ul>
  <li><strong>Địa chỉ:</strong> 517–519–521 Lương Ngọc Quyến, TP. Thái Nguyên</li>
  <li><strong>Điện thoại:</strong> 0208 3855 208</li>
  <li><strong>Hotline:</strong> 0868 285 123</li>
  <li><strong>Website:</strong> <a href="http://benhvienthainguyen.com" target="_blank">benhvienthainguyen.com</a></li>
</ul>

<h3>Bệnh viện Trung ương Thái Nguyên</h3>
<ul>
  <li><strong>Địa chỉ:</strong> 479 Lương Ngọc Quyến, TP. Thái Nguyên</li>
  <li><strong>Điện thoại:</strong> 0208 3855 125</li>
  <li><strong>Hotline:</strong> 0385 116 115</li>
  <li><strong>Email:</strong> <a href="mailto:vanthu@bvdktuthainguyen.gov.vn">vanthu@bvdktuthainguyen.gov.vn</a></li>
  <li><strong>Website:</strong> <a href="http://bvdktuthainguyen.gov.vn" target="_blank">bvdktuthainguyen.gov.vn</a></li>
</ul>

<h2>🏥 Trung tâm y tế tuyến huyện, thành phố</h2>

<h3>Trung tâm Y tế TP. Thái Nguyên</h3>
<ul>
  <li><strong>Địa chỉ:</strong> 34 Phan Đình Phùng, TP. Thái Nguyên</li>
  <li><strong>Điện thoại:</strong> 0967 721 212</li>
</ul>

<h3>Trung tâm Y tế huyện Phú Lương</h3>
<ul>
  <li><strong>Cơ sở 1:</strong> Tổ dân phố Cầu Trắng, thị trấn Đu, Phú Lương</li>
  <li><strong>Cơ sở 2:</strong> Tổ dân phố Tràng Học, thị trấn Đu, Phú Lương</li>
  <li><strong>Điện thoại:</strong> (0208) 3874205</li>
  <li><strong>Đường dây nóng:</strong> 0967 331 212</li>
  <li><strong>Email:</strong> <a href="mailto:trungtamyt.phuluong@thainguyen.gov.vn">trungtamyt.phuluong@thainguyen.gov.vn</a></li>
</ul>

<h2>🏥 Trạm y tế cơ sở</h2>

<h3>Trạm Y tế xã Yên Lạc (Phú Lương)</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Xóm Yên Thủy 1, xã Yên Lạc</li>
  <li><strong>Trưởng trạm:</strong> Bác sĩ Dương Hải Yến</li>
  <li><strong>SĐT cá nhân:</strong> 0968 899 726</li>
  <li><strong>Đường dây nóng:</strong> 0869 516 483</li>
  <li><strong>Điện thoại bàn:</strong> (0208) 3774075</li>
  <li><strong>Email:</strong> <a href="mailto:yenlac.tramyte@gmail.com">yenlac.tramyte@gmail.com</a></li>
</ul>

<h3>Trạm Y tế xã Vô Tranh (Phú Lương)</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Xã Vô Tranh, huyện Phú Lương</li>
  <li><strong>Phụ trách:</strong> Y sĩ Phạm Thị Ánh</li>
  <li><strong>SĐT cá nhân:</strong> 0342 848 346</li>
  <li><strong>Đường dây nóng:</strong> 0869 516 487</li>
  <li><strong>Điện thoại bàn:</strong> (0208) 3877006</li>
  <li><strong>Email:</strong> <a href="mailto:tramytevotranh@gmail.com">tramytevotranh@gmail.com</a></li>
</ul>

<h3>Trạm Y tế phường Đông Cao (TP. Phổ Yên)</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Phường Đông Cao, TP. Phổ Yên</li>
  <li><strong>Chú ý:</strong> Có nhân viên y tế túc trực 24/24</li>
</ul>

      '''
    },
    {
      'title': '3. Hỗ trợ tìm nhà hãng',
      'content': '''
<h2>🍽️ Nhà hàng buffet & lẩu nướng</h2>

<h3>Nhà hàng Buffet Thành Công</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Phố Phan Bội Châu, Phường Phan Đình Phùng, TP. Thái Nguyên</li>
  <li><strong>Điện thoại:</strong> 0988 520 719</li>
  <li><strong>Mô tả:</strong> Buffet Âu – Á đa dạng, không gian sang trọng, phù hợp cho tiệc gia đình, liên hoan.</li>
</ul>

<h3>Nhà hàng Thái Nguyên Xanh</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Số 26, Đường Phan Bội Châu, Phường Phan Đình Phùng, TP. Thái Nguyên</li>
  <li><strong>Điện thoại:</strong> 0327 262 626 / 0208 3666 766</li>
  <li><strong>Mô tả:</strong> Nổi tiếng với món ăn Hàn Quốc, không gian hiện đại, phục vụ buffet đa dạng.</li>
</ul>

<h3>GoGi House – Nướng Hàn Quốc</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Lô 404, 405/01, Khu Dân Cư Số 5, Phường Phan Đình Phùng, TP. Thái Nguyên</li>
  <li><strong>Mô tả:</strong> Chuỗi nhà hàng nướng Hàn Quốc nổi tiếng, thực đơn phong phú, không gian thoáng mát.</li>
</ul>

<h2>🐟 Nhà hàng hải sản & đặc sản</h2>

<h3>Hải sản Biển Đông</h3>
<ul>
  <li><strong>Địa chỉ:</strong> TP. Thái Nguyên</li>
  <li><strong>Mô tả:</strong> Chuyên hải sản tươi sống, không gian rộng rãi, phù hợp cho các buổi tụ họp.</li>
</ul>

<h3>Nhà hàng Thái Việt Gia</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Ngõ 17, Phường Phan Đình Phùng, TP. Thái Nguyên</li>
  <li><strong>Mô tả:</strong> Không gian sang trọng, phục vụ các món ăn truyền thống Việt Nam.</li>
</ul>

<h2>🍜 Quán ăn truyền thống & đặc sản địa phương</h2>

<h3>Quán bánh cuốn Chờ</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Số 01, Tổ 13, Quán Triều, TP. Thái Nguyên</li>
  <li><strong>Mô tả:</strong> Nổi tiếng với món bánh cuốn thơm ngon, không gian ấm cúng.</li>
</ul>

<h3>288 Restaurant</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Tổ 31, Đường Phan Đình Phùng, TP. Thái Nguyên</li>
  <li><strong>Mô tả:</strong> Không gian rộng rãi, thực đơn đa dạng từ các vùng miền, phù hợp cho tiệc gia đình, liên hoan.</li>
</ul>

      '''
    },
    {
      'title': '4. Hỗ trợ tìm khách sạn',
      'content': '''
<h2>🏨 Khách sạn cao cấp & tiện nghi hiện đại</h2>

<h3>MAY PLAZA HOTEL</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Số 142, đường Hoàng Văn Thụ, TP. Thái Nguyên</li>
  <li><strong>Điểm nổi bật:</strong> Khách sạn 4 sao với phòng nghỉ hiện đại, nhà hàng sang trọng và dịch vụ chuyên nghiệp.</li>
</ul>

<h3>Đông Á Plaza Hotel</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Số 668, đường Phan Đình Phùng, TP. Thái Nguyên</li>
  <li><strong>Điểm nổi bật:</strong> Không gian sang trọng, nhà hàng tầng 6 với tầm nhìn toàn thành phố, phục vụ ẩm thực đa dạng.</li>
</ul>

<h3>The King Hotel - Condotel Thai Nguyen</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Khu dân cư số 5, phường Phan Đình Phùng, TP. Thái Nguyên</li>
  <li><strong>Điểm nổi bật:</strong> Căn hộ dịch vụ tiện nghi, phù hợp cho gia đình và khách công tác dài ngày.</li>
</ul>

<h2>🛏️ Khách sạn 3 sao & tầm trung</h2>

<h3>X Hotel Thái Nguyên</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Số 38, tổ 1, phường Tân Thịnh, TP. Thái Nguyên</li>
  <li><strong>Điểm nổi bật:</strong> Hồ bơi ngoài trời, khu vườn xanh mát, phòng nghỉ tiện nghi.</li>
</ul>

<h3>Khách sạn Habana</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Số 318, đường Quang Trung, TP. Thái Nguyên</li>
  <li><strong>Điểm nổi bật:</strong> Vị trí trung tâm, phòng nghỉ sạch sẽ, dịch vụ thân thiện.</li>
</ul>

<h3>Kim Thái Hotel</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Số 1, đường Hoàng Văn Thụ, TP. Thái Nguyên</li>
  <li><strong>Điểm nổi bật:</strong> Phòng nghỉ hiện đại, dịch vụ chuyên nghiệp, giá cả hợp lý.</li>
</ul>

<h3>Da Huong Hotel</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Số 2, đường Hoàng Văn Thụ, TP. Thái Nguyên</li>
  <li><strong>Điểm nổi bật:</strong> Nhà hàng phục vụ ẩm thực Á - Âu, phòng xông hơi và massage hiện đại.</li>
</ul>

<h2>💰 Khách sạn bình dân & giá rẻ</h2>

<h3>Queen Hotel Hoàng Gia</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Tổ 6, phường Tân Thịnh, TP. Thái Nguyên</li>
  <li><strong>Điểm nổi bật:</strong> Giá cả phải chăng, phòng nghỉ sạch sẽ, dịch vụ chu đáo.</li>
</ul>

<h3>Khách sạn Hoàng Mấm</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Số 22, đường Lương Thế Vinh, phường Quang Trung, TP. Thái Nguyên</li>
  <li><strong>Điểm nổi bật:</strong> Không gian rộng rãi, nội thất gỗ cao cấp, phù hợp cho gia đình.</li>
</ul>

<h3>Khách sạn Hoàng Yến</h3>
<ul>
  <li><strong>Địa chỉ:</strong> Số 289A, đường Phan Đình Phùng, TP. Thái Nguyên</li>
  <li><strong>Điểm nổi bật:</strong> Vị trí thuận tiện, giá cả hợp lý, phù hợp cho du khách tiết kiệm.</li>
</ul>

      '''
    },
    {
      'title': '5. Hỗ trợ lên kế hoạch vui chơi',
      'content': '''
<h2>Lịch trình tham quan Thái Nguyên thứ nhất</h2>
<ul>
  <li><strong>07:00:</strong> <strong>Di tích 60 liệt sĩ TNXP, Đại đội 915 (P. Gia Sàng, TP. Thái Nguyên)</strong><br> 
  Tưởng niệm 60 liệt sĩ, dâng hương, tìm hiểu lịch sử kháng chiến chống Mỹ.</li>
  
  <li><strong>08:30:</strong> <strong>Không gian văn hóa Trà Tân Cương (X. Tân Cương, TP. Thái Nguyên)</strong><br> 
  Khám phá nghề trà, tham quan, thưởng thức trà Tân Cương nổi tiếng.</li>
  
  <li><strong>11:00:</strong> <strong>Khu bảo tồn Thái Hải (X. Thịnh Đức, TP. Thái Nguyên)</strong><br>
  Trải nghiệm văn hóa dân tộc, nhà sàn, không gian thiên nhiên xanh mát.</li>
  
  <li><strong>13:00:</strong> <strong>Trung tâm Dũng Tân (P. Cải Đan, TP. Sông Công)</strong><br>
  Mua sắm, vui chơi, thưởng thức ẩm thực trong khu du lịch sinh thái.</li>
  
  <li><strong>14:30:</strong> <strong>Hồ Núi Cốc (X. Phúc Xuân, TP. Thái Nguyên)</strong><br>
  Chèo thuyền, câu cá, thư giãn ngắm cảnh hồ tuyệt đẹp.</li>
</ul>

<h2>Lịch trình tham quan Thái Nguyên thứ hai</h2>
<ul>
  <li><strong>07:00:</strong> <strong>Hồ Núi Cốc (X. Phúc Xuân, TP. Thái Nguyên)</strong><br> 
  Thưởng thức cảnh hồ đẹp, chèo thuyền, câu cá, tận hưởng không khí trong lành.</li>
  
  <li><strong>13:30:</strong> <strong>Không gian văn hóa Trà Tân Cương (X. Tân Cương, TP. Thái Nguyên)</strong><br> 
  Tìm hiểu nghề trà, thưởng thức trà Tân Cương, tham quan trưng bày văn hóa trà.</li>
  
  <li><strong>15:30:</strong> <strong>Khu bảo tồn Thái Hải (X. Thịnh Đức, TP. Thái Nguyên)</strong><br>
  Khám phá nhà sàn dân tộc, văn hóa thiểu số, thư giãn trong không gian xanh mát.</li>
</ul>

<h2>Lịch trình Khám phá lịch sử và văn hóa Thái Nguyên</h2>
<ul>
  <li><strong>07:00:</strong> <strong>Di tích 60 liệt sĩ TNXP, Đại đội 915 (P. Gia Sàng, TP. Thái Nguyên)</strong><br> 
  Tưởng niệm liệt sĩ, tìm hiểu lịch sử kháng chiến chống Mỹ.</li>
  
  <li><strong>08:30:</strong> <strong>Không gian văn hóa Trà Tân Cương (X. Tân Cương, TP. Thái Nguyên)</strong><br> 
  Khám phá nghề trà, thưởng thức trà Tân Cương, thư giãn trong không gian mở.</li>
  
  <li><strong>11:00:</strong> <strong>Khu bảo tồn Thái Hải (X. Thịnh Đức, TP. Thái Nguyên)</strong><br>
  Trải nghiệm văn hóa dân tộc thiểu số, tham quan nhà sàn, tận hưởng thiên nhiên.</li>
  
  <li><strong>13:00:</strong> <strong>Trung tâm Dũng Tân (P. Cải Đan, TP. Sông Công)</strong><br>
  Mua sắm, thưởng thức ẩm thực, tham gia hoạt động giải trí.</li>
  
  <li><strong>15:30:</strong> <strong>Hồ Núi Cốc (X. Phúc Xuân, TP. Thái Nguyên)</strong><br>
  Thư giãn ngắm cảnh hồ, chèo thuyền, tận hưởng không khí trong lành.</li>
</ul>

<h2>Lịch trình Khám Phá Thiên Nhiên và Văn Hóa</h2>
<ul>
  <li><strong>07:00 – Khu du lịch Hồ Núi Cốc</strong><br>
  <strong>Địa điểm:</strong> Xã Phúc Xuân, TP. Thái Nguyên<br>
  <strong>Mô tả:</strong> Tham quan hồ với không gian thiên nhiên đẹp, thư giãn và vui chơi.</li>

  <li><strong>10:00 – Chùa Hang</strong><br>
  <strong>Địa điểm:</strong> Xã Phú Lương, TP. Thái Nguyên<br>
  <strong>Mô tả:</strong> Ngôi chùa cổ trong hang đá, không gian thanh tịnh.</li>

  <li><strong>12:00 – Thưởng thức ẩm thực địa phương</strong><br>
  <strong>Địa điểm:</strong> Nhà hàng tại TP. Thái Nguyên<br>
  <strong>Mô tả:</strong> Thưởng thức món ngon như bánh cáy, chè Thái, cơm lam.</li>

  <li><strong>13:30 – Không gian văn hóa Trà Tân Cương</strong><br>
  <strong>Địa điểm:</strong> Xã Tân Cương, TP. Thái Nguyên<br>
  <strong>Mô tả:</strong> Tìm hiểu và thưởng thức trà tại vùng chè nổi tiếng.</li>

  <li><strong>15:30 – Khu Bảo tồn làng nhà sàn Thái Hải</strong><br>
  <strong>Địa điểm:</strong> Xã Thịnh Đức, TP. Thái Nguyên<br>
  <strong>Mô tả:</strong> Khám phá văn hóa các dân tộc thiểu số tại làng nhà sàn.</li>
</ul>

      '''
    },
    {
      'title': '5. Hỗ trợ di chuyển',
      'content': '''
<ul>
  <li>
    <strong>Taxi Mai Linh</strong> – 0208.6.25.25.25<br>
    Đây là hãng taxi lớn, uy tín, hoạt động trên toàn quốc, có mặt tại nhiều điểm du lịch và trung tâm thành phố Thái Nguyên.
  </li>
  <li>
    <strong>Taxi Bình An</strong> – 0208.3.54.54.54<br>
    Hãng taxi phục vụ tốt tại thành phố và các huyện lân cận, giá cả hợp lý, hỗ trợ chở hàng nhẹ.
  </li>
  <li>
    <strong>Taxi Thái Bảo</strong> – 0208.3.737.737<br>
    Có nhiều xe, phục vụ cả đi nội tỉnh và ngoại tỉnh, được đánh giá có tài xế thân thiện.
  </li>
  <li>
    <strong>Taxi Hoa Mai</strong> – 1900.9262<br>
    Hoạt động mạnh ở khu vực các khu công nghiệp và khu dân cư, giá mềm, phục vụ nhanh.
  </li>
  <li>
    <strong>Taxi Hà Lan</strong> – 0208.3.759.759<br>
    Ngoài taxi truyền thống, hãng này còn có xe dịch vụ đưa đón sân bay, xe du lịch đường dài.
  </li>
  <li>
    <strong>Taxi Đức Quỳnh</strong> – 0208.3.855.855<br>
    Xe đời mới, nội thất sạch sẽ, thường phục vụ khách đi tỉnh hoặc đi tham quan.
  </li>
  <li>
    <strong>Taxi Việt Bắc</strong> – 0208.3.658.658<br>
    Là hãng taxi quen thuộc của người dân Thái Nguyên, có dịch vụ gọi xe qua điện thoại nhanh chóng.
  </li>
  <li>
    <strong>Taxi Phú Lương Sao</strong> – 0208.3.676.888<br>
    Phục vụ tốt tại khu vực Phú Lương và các vùng phụ cận, được đánh giá lái xe an toàn.
  </li>
  <li>
    <strong>Taxi Phú Bình</strong> – 0208.3.568.568<br>
    Giá cả phải chăng, phù hợp cho học sinh, sinh viên và người lao động.
  </li>
  <li>
    <strong>Taxi Xanh SM (xe điện)</strong> – 1900.2088<br>
    Hãng taxi sử dụng xe điện VinFast, không mùi xăng, sạch sẽ và thân thiện với môi trường.
  </li>
  <li>
    <strong>Taxi G7 Thái Nguyên</strong> – 0208.3.65.65.65<br>
    Mới gia nhập thị trường Thái Nguyên, có ứng dụng đặt xe tiện lợi, phục vụ nhanh.
  </li>
</ul>
      '''
    },
  ];

  bool get _isMobile {
    return defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;
  }

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/main-bg.mp4')
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.setVolume(0); // mute
        _videoController.play();
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              getFirstArea(),
              const SizedBox(height: 150),
              getSecondArea(),
              const SizedBox(height: 100),
              getThirdArea(),
              getSupportArea(),
              getFourthArea(),
              getFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFirstArea() {
    return SizedBox(
      height: 900,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_videoController.value.isInitialized)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _videoController.value.size.width,
                height: _videoController.value.size.height,
                child: VideoPlayer(_videoController),
              ),
            ),
          // Optional overlay
          FittedBox(
            fit: BoxFit.cover,
            child: Container(
              width: _videoController.value.size.width,
              height: _videoController.value.size.height,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          // Foreground content
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Du lịch Thái Nguyên",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(0.7, 0.7),
                        blurRadius: 0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Trải nghiệm xứ Trà, đậm đà bản sắc.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(0.7, 0.7),
                        blurRadius: 0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  '''Khám phá đồi chè Tân Cương, Hồ Núi Cốc thơ mộng và di sản cách mạng đặc sắc.
Trung tâm giáo dục, công nghiệp và đầu tư chiến lược phía Bắc.
Hãy đến Thái Nguyên – nơi hội tụ thiên nhiên, con người và tiềm năng phát triển!''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(0.7, 0.7),
                        blurRadius: 0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getFirstArea1() {
    return Container(
      height: 900,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/main.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black12, // dark overlay for better text contrast
            BlendMode.darken,
          ),
        ),
      ),
      child: const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Thái Nguyên",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      offset: Offset(0.7, 0.7),
                      blurRadius: 0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Vùng Đất Trà, Văn Hóa và Cơ Hội',
                style: TextStyle(fontSize: 20, height: 2),
              ),
              SizedBox(height: 30),
              Text(
                '''Khám phá đồi chè Tân Cương, Hồ Núi Cốc thơ mộng và di sản cách mạng đặc sắc.
Trung tâm giáo dục, công nghiệp và đầu tư chiến lược phía Bắc.
Hãy đến Thái Nguyên – nơi hội tụ thiên nhiên, con người và tiềm năng phát triển!''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSecondArea() {
    return LayoutBuilder(builder: (context, constraints) {
      const double height = 600;
      double viewportFraction = 0.8;

      if (constraints.maxWidth > 600) {
        viewportFraction = 0.5;
      }

      return Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: height,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: viewportFraction,
              ),
              items: imageDataList.map((item) {
                return Builder(
                  builder: (context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: Colors.green.shade800,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  item['image'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  filterQuality: FilterQuality.high,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                          child: Text('Image load failed')),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['description'],
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      html.window.open(item['url'], '_blank');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orangeAccent,
                                    ),
                                    child: const Text(
                                      'Khám phá thêm',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Positioned(
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    size: 32, color: Colors.white),
                onPressed: () {
                  _carouselController.previousPage();
                },
                tooltip: 'Previous',
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black45,
                  shape: const CircleBorder(),
                ),
              ),
            ),
            Positioned(
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios,
                    size: 32, color: Colors.white),
                onPressed: () {
                  _carouselController.nextPage();
                },
                tooltip: 'Next',
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black45,
                  shape: const CircleBorder(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget getThirdArea() {
    return RawKeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKey: (event) {
        if (!_isMobile && event is RawKeyEvent) {
          final ctrl = event.isControlPressed;
          if (ctrl != _ctrlPressed) {
            setState(() {
              _ctrlPressed = ctrl;
            });
          }
        }
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Bản đồ du lịch Thái Nguyên",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 50),
            LayoutBuilder(
              builder: (context, constraints) {
                return AspectRatio(
                  aspectRatio: 1 / 1, // You can change based on your map aspect
                  child: InteractiveViewer(
                    maxScale: 3,
                    minScale: 1,
                    scaleEnabled: _isMobile || _ctrlPressed,
                    boundaryMargin: const EdgeInsets.all(80),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/map1.jpg',
                            fit: BoxFit.contain, // Keeps image proportions
                          ),
                        ),
                        const DistrictOverlay(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getFourthArea() {
    return Builder(
      builder: (context) {
        Future<void> sendFeedback() async {
          if (_formKey.currentState!.validate()) {
            final subject = "Đóng góp từ ${nameController.text}";
            final body = messageController.text;
            final email = dotenv.env['RESPONSE_MAIL'] ?? '';

            var url = Uri.https('freeemailapi.vercel.app', '/sendEmail/');
            await http.post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(
                  {"toEmail": email, "subject": subject, "body": body}),
            );

            setState(() {
              nameController.text = '';
              messageController.text = '';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gửi ý kiến thành công!')),
            );
          }
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          color: Colors.white,
          width: double.infinity,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Material(
                elevation: 0,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Gửi ý kiến đóng góp',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Tên của bạn',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Vui lòng nhập tên'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: messageController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Ý kiến của bạn',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Vui lòng nhập nội dung'
                            : null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: sendFeedback,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.green.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Gửi phản hồi',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getFooter() {
    final phone = dotenv.env['FOOTER_PHONE'] ?? '';
    final mail = dotenv.env['FOOTER_MAIL'] ?? '';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: Colors.grey[200], // Màu nền của footer
      child: Column(
        children: [
          const Text(
            'Liên hệ với chúng tôi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 8,
            width: double.infinity,
          ),
          Text(
            'Email: $mail',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            "Số điện thoại: $phone",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 12),
          // const Text(
          //   '© 2025 Du Lịch Thái Nguyên. All rights reserved.',
          //   style: TextStyle(fontSize: 14, color: Colors.black54),
          // ),
        ],
      ),
    );
  }

  Widget getSupportArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Hỗ trợ & Câu hỏi thường gặp",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green.shade800,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    childrenPadding: const EdgeInsets.all(16),
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Text(
                      item['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: HtmlWidget(item['content'] ?? ""),
                        // child: Text(
                        //   item['content'],
                        //   style: const TextStyle(
                        //     fontSize: 16,
                        //     height: 1.5,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
