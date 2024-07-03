from yaml import load,safe_load,YAMLError

input_file = "./pubspec.yaml"
output_file = "lib/l10n/localization_extension.dart"


with open(input_file) as stream:
    try:
       data = safe_load(stream)
    except YAMLError as exc:
        print(exc)

print(data['version'])