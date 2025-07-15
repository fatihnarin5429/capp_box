enum MediaType { text, photo, video, voice, mail }

MediaType mediaTypeFromString(String type) {
  switch (type) {
    case 'image':
    case 'photo':
      return MediaType.photo;
    case 'video':
      return MediaType.video;
    case 'audio':
    case 'voice':
      return MediaType.voice;
    case 'text':
      return MediaType.text;
    case 'mail':
      return MediaType.mail;
    default:
      return MediaType.text; // veya bir 'unknown' ekleyebilirsin
  }
}

String mediaTypeToString(MediaType type) {
  switch (type) {
    case MediaType.photo:
      return 'image';
    case MediaType.video:
      return 'video';
    case MediaType.voice:
      return 'audio';
    case MediaType.text:
      return 'text';
    case MediaType.mail:
      return 'mail';
    default:
      return 'text';
  }
}
