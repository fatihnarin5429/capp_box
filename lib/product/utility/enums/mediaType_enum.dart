enum MediaType { text, photo, video, voice }

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
    default:
      return MediaType.text;
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
    default:
      return 'text';
  }
}
