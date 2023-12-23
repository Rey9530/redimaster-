import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:credimaster/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageView extends StatefulWidget {
  /// Crea un visor de imagenes en un carrusel, que al seleccionar una imagen se
  /// muestra en pantalla completa, permitiendo hacer zoom en cada imagen.
  ///
  /// Recibe las imagenes en una lista de Strings, estas imagenes deben provenir
  /// de internet
  ///
  /// Hace uso de las librerias `cached_network_image`, `photo_view`, `flutter_sv`
  ///
  /// Puede usar imagenes SVG pero esa opción no esta paremetrizada, también se
  /// podría modificar para para mostrar imagenes que estén en los assets

  const ImageView({
    super.key,
    required this.documents,
    this.verticalGallery = false,
  });

  /// Lista de imagenes a mostrar
  ///
  /// Una lista de las urls de las imagenes en formato `String` este campo no puede ser nulo
  final BuiltList<Documento> documents;

  /// Indica si queremos que las imagenes se desplacen de forma vertical
  ///
  /// Debe ser de tipo `bool` por defecto tiene asignado false
  final bool verticalGallery;

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  // Almacenara la lista de imagenes que se mostraran en el image view
  late List<GalleryItem> galleryItems;

  @override
  Widget build(BuildContext context) {
    // Convertimos la lista de strings que contienen las imagenes en una lista
    // de obtetos de tipo Gallery item
    galleryItems = buildGallery(widget.documents);

    return Column(
      children: galleryItems
          .map(
            (item) => Column(
              children: [
                ListTile(
                  onTap: () => open(context, int.parse(item.id)),
                  leading: Hero(
                    tag: item.id,
                    child: SizedBox(
                        width: 100,
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageUrl: item.resource,
                          fit: BoxFit.cover,
                        )),
                  ),
                  title: Text(item.name),
                  subtitle: Text(item.description),
                ),
                const Divider(),
              ],
            ),
          )
          .toList(),
    );
  }

  void open(BuildContext context, final int index) {
    /// Abre la imagen seleccionada, enviando el context como patametro y el
    /// indice de la imagen

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection:
              widget.verticalGallery ? Axis.vertical : Axis.horizontal,
        ),
      ),
    );
  }

  List<GalleryItem> buildGallery(BuiltList<Documento> images) {
    // Transforma la lista de Strings que contienen las imagenes en una lista de
    // GalleryItems para ser mostrados en el image_view

    List<GalleryItem> galleryItems = [];

    for (var i = 0; i < images.length; i++) {
      galleryItems.add(
        GalleryItem(
          id: '$i',
          resource: images[i].foto,
          name: images[i].nombre,
          description: images[i].descripcion,
        ),
      );
    }

    return galleryItems;
  }
}

// *****************************************************************************
// * Creación de widgets necesarios para el funcionamiento del image view
// *****************************************************************************

class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail({
    super.key,
    required this.galleryExampleItem,
    required this.onTap,
  });

  final GalleryItem galleryExampleItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryExampleItem.id,
          child: CachedNetworkImage(
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageUrl: galleryExampleItem.resource,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    super.key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final Decoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryItem> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: widget.backgroundDecoration,
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: _buildItem,
                  itemCount: widget.galleryItems.length,
                  loadingBuilder: widget.loadingBuilder,
                  // backgroundDecoration: widget.backgroundDecoration,
                  pageController: widget.pageController,
                  onPageChanged: onPageChanged,
                  scrollDirection: widget.scrollDirection,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Imagen ${currentIndex + 1} / ${widget.galleryItems.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      decoration: null,
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: SafeArea(
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final GalleryItem item = widget.galleryItems[index];
    return item.isSvg
        ? PhotoViewGalleryPageOptions.customChild(
            child: SizedBox(
              width: 300,
              height: 300,
              child: SvgPicture.asset(
                item.resource,
                height: 200.0,
              ),
            ),
            childSize: const Size(300, 300),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
            maxScale: PhotoViewComputedScale.covered * 1.1,
            heroAttributes: PhotoViewHeroAttributes(tag: item.id),
          )
        : PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(item.resource),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
            maxScale: PhotoViewComputedScale.covered * 1.1,
            heroAttributes: PhotoViewHeroAttributes(tag: item.id),
          );
  }
}

// *****************************************************************************
// * Se define el tipo de objeto necesario para ser mostrado en el image view
// *****************************************************************************
class GalleryItem {
  GalleryItem({
    required this.id,
    required this.resource,
    this.isSvg = false,
    required this.name,
    required this.description,
  });

  final String id;
  final String resource;
  final String name;
  final String description;
  final bool isSvg;
}
