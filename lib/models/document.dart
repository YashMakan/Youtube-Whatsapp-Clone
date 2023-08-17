class Document {
  final String fileName;
  final int bytesSize;
  final String fileType;

  Document(this.fileName, this.bytesSize, this.fileType);

  factory Document.fromJson(Map<String, dynamic> data) => Document(
        data['fileName'],
        data['bytesSize'],
        data['fileType'],
      );

  Map<String, dynamic> toJson() => {
    'fileName': fileName,
    'bytesSize': bytesSize,
    'fileType': fileType,
  };
}
