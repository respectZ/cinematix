import 'package:flutter/material.dart';
import '../../widget/cinematix_home.dart';

class MainMenu extends StatelessWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CinematixHome(
        onGoing: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://awsimages.detik.net.id/visual/2022/01/19/moon-knight.jpeg?w=650")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://gamerbraves.sgp1.cdn.digitaloceanspaces.com/2022/01/uncharted.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/03/16/461973433.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://cdn0-production-images-kly.akamaized.net/rCq5sA8E4eXZVeIU2p7VHg4ZkOE=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/899273/original/068142200_1434084122-jennifer-lawrence-in-the-hunger-games-mockingjay-part-2-2015.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://img.tek.id/img/content/2020/01/03/24173/avengers-endgame-kembali-ungguli-avatar-rLuWTbVISy.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://adhasusanto.com/wp-content/uploads/2021/05/cerita-film-finding-nemo.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://www.dewimagazine.com/img/images/FINDING%20DORY.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://w0.peakpx.com/wallpaper/103/270/HD-wallpaper-movie-ratatouille.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://cdn.medcom.id/dynamic/content/2016/08/29/575490/kl5CeFJY3K.jpg?w=480")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "http://asset-a.grid.id/crop/0x0:0x0/x/photo/2019/04/10/3423293704.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://cdn0-production-images-kly.akamaized.net/LqkYmFINhV0bH6aBVftnrvb4OP4=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/3246878/original/093656700_1600854405-Doraemon__Stand_by_Me_Landscape.jpg"))))
        ],
        upComing: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://media.suara.com/pictures/653x366/2022/02/26/59600-the-batman.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://gamerbraves.sgp1.cdn.digitaloceanspaces.com/2022/01/uncharted.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/03/16/461973433.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://cdn0-production-images-kly.akamaized.net/rCq5sA8E4eXZVeIU2p7VHg4ZkOE=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/899273/original/068142200_1434084122-jennifer-lawrence-in-the-hunger-games-mockingjay-part-2-2015.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://img.tek.id/img/content/2020/01/03/24173/avengers-endgame-kembali-ungguli-avatar-rLuWTbVISy.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://adhasusanto.com/wp-content/uploads/2021/05/cerita-film-finding-nemo.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://www.dewimagazine.com/img/images/FINDING%20DORY.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://w0.peakpx.com/wallpaper/103/270/HD-wallpaper-movie-ratatouille.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://cdn.medcom.id/dynamic/content/2016/08/29/575490/kl5CeFJY3K.jpg?w=480")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "http://asset-a.grid.id/crop/0x0:0x0/x/photo/2019/04/10/3423293704.jpg")))),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://cdn0-production-images-kly.akamaized.net/LqkYmFINhV0bH6aBVftnrvb4OP4=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/3246878/original/093656700_1600854405-Doraemon__Stand_by_Me_Landscape.jpg"))))
        ],
      ),
    );
  }
}
