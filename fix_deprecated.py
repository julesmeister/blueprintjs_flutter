import os
import re

def fix_with_opacity(file_path):
    """Replace withOpacity with withValues(alpha:)"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Pattern to match .withOpacity(value)
    pattern = r'\.withOpacity\(([\d.]+)\)'
    replacement = r'.withValues(alpha: \1)'
    
    new_content = re.sub(pattern, replacement, content)
    
    if new_content != content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        return True
    return False

def fix_super_key(file_path):
    """Replace Key? key with super.key"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Pattern to match constructor with Key? key parameter
    pattern = r'(const\s+\w+\(\s*\{\s*)Key\?\s+key(,[\s\S]*?\}\s*\)\s*:\s*super\s*\(\s*key:\s*key\s*\))'
    replacement = r'\1super.key\2'
    
    new_content = re.sub(pattern, replacement, content)
    
    # Remove the super(key: key) part since super.key handles it
    pattern2 = r'(\)\s*):\s*super\s*\(\s*key:\s*key\s*\)(;)?'
    replacement2 = r'\1\2'
    new_content = re.sub(pattern2, replacement2, new_content)
    
    if new_content != content:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        return True
    return False

# Fix all Dart files
for root, dirs, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            file_path = os.path.join(root, file)
            opacity_fixed = fix_with_opacity(file_path)
            key_fixed = fix_super_key(file_path)
            if opacity_fixed or key_fixed:
                print(f"Fixed: {file_path}")

print("Done!")