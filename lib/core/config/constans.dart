/// The current environment of the application.
///
/// **Possible Values:**
/// - `dev`: Development environment.
/// - `uat`: Quality Assurance environment.
/// - `prod`: Production environment.
const String env = 'dev';

/// The version of the application.
///
/// Combines the version number with the current environment.
const String versionApp = '1.0.0+1 :: $env';

/// The base URL for The Movie Database API.
const String baseUrl = 'https://api.themoviedb.org';
const String baseUrlMedicos = 'https://api.themoviedb.org';
const String baseUrlAsistentes = 'https://api.themoviedb.org';
