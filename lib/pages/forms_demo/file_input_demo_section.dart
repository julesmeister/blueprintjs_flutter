import 'package:flutter/material.dart';
import '../../theme/blueprint_colors.dart';
import '../../components/blueprint_button.dart';
import '../../components/blueprint_file_input.dart';
import '../../components/blueprint_common.dart';
import '../../components/blueprint_card.dart';

class FileInputDemoSection extends StatefulWidget {
  const FileInputDemoSection({super.key});

  @override
  State<FileInputDemoSection> createState() => _FileInputDemoSectionState();
}

class _FileInputDemoSectionState extends State<FileInputDemoSection> {
  String? _selectedFile;
  String? _selectedImage;

  void _selectFile(String type) {
    setState(() {
      switch (type) {
        case 'document':
          _selectedFile = 'selected_document.txt';
          break;
        case 'image':
          _selectedImage = 'selected_image.jpg';
          break;
        default:
          break;
      }
    });
    _showSnackBar('File selected: $type');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: BlueprintColors.intentPrimary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlueprintCard(
      padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic File Input',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintFileInputs.simple(
              text: _selectedFile ?? 'Choose file...',
              onPressed: () => _selectFile('document'),
              fill: true,
            ),
            const SizedBox(height: 16),
            
            Text(
              'Image File Input',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintFileInputs.withIcon(
              icon: Icons.image,
              text: _selectedImage ?? 'Choose image...',
              onPressed: () => _selectFile('image'),
              fill: true,
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Success Intent',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: BlueprintColors.gray1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlueprintFileInputs.withIntent(
                        intent: BlueprintIntent.success,
                        text: 'Upload complete',
                        onPressed: () => _selectFile('success'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Large Size',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: BlueprintColors.gray1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlueprintFileInputs.large(
                        text: 'Large file input',
                        onPressed: () => _selectFile('large'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Text(
              'With Selection',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: BlueprintColors.gray1,
              ),
            ),
            const SizedBox(height: 8),
            BlueprintFileInputs.withSelection(
              fileName: 'document.pdf',
              onPressed: () => _selectFile('pdf'),
              fill: true,
            ),
          ],
        ),
    );
  }
}