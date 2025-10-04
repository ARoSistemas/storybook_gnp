import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:storybook_gnp/src/modules/file_operations/file_operations_screen.dart';
import 'package:storybook_gnp/src/modules/home/home_page.dart';
import 'package:storybook_gnp/src/modules/intro/intro_page.dart';
import 'package:storybook_gnp/src/modules/intro/pages/snack_overlay.dart';
import 'package:storybook_gnp/src/modules/login/login_page.dart';

final class AppNavigation {
  static final List<GetPage> pages = [
    IntroPage.page,
    SnackBarOverlay.page,
    FileOperationsScreen.page,
    // ConvenioMedicoPage.page,
    // DoctorRegisterPage.page,
    HomePage.page,
    LoginPage.page,
    // MiPerfilPage.page,
    // NuevaSolicitudPage.page,
    // SolicitudDocumentacionPage.page,
    // ViewDocument.page,
    // WelcomePage.page,
    // DoctorRegisterPage.page,
    // NuevaSolicitudPage.page,
    // SolicitudDocumentacionPage.page,
    // MiPerfilPage.page,
    // DatosPersonalesPhone.page,
    // DatosAcademicosPhone.page,
    // DatosFiscalesPhone.page,
    // CambiarContrasenia.page,
    // AgregarUsuario.page,
    // ActualizarUsuario.page,
    // SolicitudUploadPhone.page,
    // TabuladoresPage.page,
    // AnexosPage.page,
    // DirectorioPage.page,
    // BeneficiosPage.page,
    // RegistroPage.page,
  ];
}
