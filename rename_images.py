import os
from PIL import Image, ExifTags
from datetime import datetime

# Set the directory path
directory = '/Users/shashvatgarg/development/Projects/Photography/web/images'
output_ext = '.jpg'

# Supported input formats
valid_extensions = ('.jpg', '.jpeg', '.png', '.bmp', '.tiff')

# Helper to extract datetime from EXIF or fallback to last modified time
def get_image_timestamp(path):
    try:
        with Image.open(path) as img:
            exif = img._getexif()
            if exif:
                for tag, value in exif.items():
                    decoded = ExifTags.TAGS.get(tag, tag)
                    if decoded == "DateTimeOriginal":
                        return datetime.strptime(value, '%Y:%m:%d %H:%M:%S')
    except Exception:
        pass
    return datetime.fromtimestamp(os.path.getmtime(path))



def get_images(directory):
    images = []
    for filename in os.listdir(directory):
        if filename.lower().endswith(valid_extensions):
            full_path = os.path.join(directory, filename)
            images.append(full_path)
        else:
            print(f"Skipping unsupported file: {filename}")
    return images

def convert_image_to_jpeg(image_path):
    try:
        with Image.open(image_path) as img:
            img = img.convert('RGB')
            new_path = os.path.splitext(image_path)[0] + output_ext
            img.save(new_path, 'JPG', quality=100)
            print(f'✅ Converted and saved: {new_path}')
            return new_path
    except Exception as e:
        print(f'❌ Failed to convert {image_path}: {e}')
        return None
    
def rename_image(images):
    number = 1
    for i in images:
        if i.lower().endswith(output_ext):
            pass
        else:
            convert_image_to_jpeg(i)
        
        new_name = f'image{number}{output_ext}'
        new_path = os.path.join(directory, new_name)
        os.rename(i, new_path)
        print(f'✅ Renamed {i} to {new_name}')
        number += 1
    return number

number = rename_image(get_images(directory))

print("Total images found:", len(get_images(directory)))
print("Total images processed:", number-1)

# Step 2: Process and convert images
# for index, (timestamp, old_path) in enumerate(image_paths, start=1):
#     try:
#         with Image.open(old_path) as img:
#             # Convert to RGB in case image is in P or RGBA mode
#             img = img.convert('RGB')

#             new_filename = f'image{index}{output_ext}'
#             new_path = os.path.join(directory, new_filename)

#             img.save(new_path, 'JPEG', quality=95)
#             print(f'✅ Converted and saved: {new_filename}')
#     except Exception as e:
#         print(f'❌ Failed to process {old_path}: {e}')
#     finally:
#         # Optional: Remove the original file only if the new one was saved
#         if old_path.lower() != new_path.lower() and os.path.exists(old_path):
#             try:
#                 os.remove(old_path)
#                 print(f'🗑️ Removed original: {os.path.basename(old_path)}')
#             except Exception as e:
#                 print(f'⚠️ Failed to delete original {old_path}: {e}')

print("\n🎉 All images processed and renamed based on capture date.")
