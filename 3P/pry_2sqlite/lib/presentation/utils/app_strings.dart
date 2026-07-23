import '../providers/theme_provider.dart';

class AppStrings {
  static String appTitle(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Mis contactos' : 'My contacts';

  static String homeTitle(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Agenda personal' : 'Personal agenda';

  static String homeSubtitle(AppLanguage lang) => lang == AppLanguage.es
      ? 'Guarda contactos, búscalos rápido y llama con un toque.'
      : 'Save contacts, find them fast, and call with a tap.';

  static String heroBadge(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Diseño modular' : 'Modular design';

  static String heroRecords(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Contactos' : 'Contacts';

  static String formTitle(AppLanguage lang, bool editing) => editing
      ? (lang == AppLanguage.es ? 'Editar contacto' : 'Edit contact')
      : (lang == AppLanguage.es ? 'Agregar contacto' : 'Add contact');

  static String formSubtitle(AppLanguage lang) => lang == AppLanguage.es
      ? 'Completa los datos para guardar la información en tu agenda.'
      : 'Fill in the details to store the information in your agenda.';

  static String saveButton(AppLanguage lang, bool editing) => editing
      ? (lang == AppLanguage.es ? 'Actualizar contacto' : 'Update contact')
      : (lang == AppLanguage.es ? 'Guardar contacto' : 'Save contact');

  static String savedContactsTitle(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Contactos guardados' : 'Saved contacts';

  static String savedContactsSubtitle(AppLanguage lang) => lang == AppLanguage.es
      ? 'Busca, ordena y administra tus registros.'
      : 'Search, sort, and manage your entries.';

  static String searchHint(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Buscar por nombre, teléfono o correo' : 'Search by name, phone, or email';

  static String emptyStateTitle(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Todavía no tienes contactos' : 'You do not have contacts yet';

  static String emptyStateSubtitle(AppLanguage lang) => lang == AppLanguage.es
      ? 'Agrega tu primer contacto desde el formulario superior.'
      : 'Add your first contact from the form above.';

  static String totalLabel(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Total' : 'Total';

  static String withEmailLabel(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Con correo' : 'With email';

  static String contactsTab(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Contactos' : 'Contacts';

  static String settingsTab(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Ajustes' : 'Settings';

  static String homeTab(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Inicio' : 'Home';

  static String settingsTitle(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Ajustes' : 'Settings';

  static String darkMode(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Modo oscuro' : 'Dark mode';

  static String language(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Idioma' : 'Language';

  static String spanish(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Español' : 'Spanish';

  static String english(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Inglés' : 'English';

  static String languageDescription(AppLanguage lang) => lang == AppLanguage.es
      ? 'Cambia el idioma de la interfaz entre español e inglés.'
      : 'Switch the interface language between Spanish and English.';

  static String themeDescription(AppLanguage lang) => lang == AppLanguage.es
      ? 'Usa un tema claro inspirado en Spotify o un modo oscuro más profundo.'
      : 'Use a Spotify-inspired light theme or a deeper dark mode.';

  static String editMode(AppLanguage lang) =>
      lang == AppLanguage.es ? 'Modo edición activo' : 'Edit mode active';

  static String editHint(AppLanguage lang) => lang == AppLanguage.es
      ? 'Revisa los campos antes de actualizar.'
      : 'Review the fields before updating.';
}
