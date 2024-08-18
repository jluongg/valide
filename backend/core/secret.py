from cryptography.fernet import Fernet
import sys
from pathlib import Path
import os


# Generate a crypting key
def generate_key():
    """
    Function to be called if the --generate flag is present.
    """
    print(Fernet.generate_key())
    print("SAVE THE PASSWORD")


# Encrypt JSON File
def encrypt_json(input_file: Path):
    """
    Encrypts the contents of a file and writes the encrypted data to a new file with '.enc' extension.

    Args:
        input_path (Path): The path to the input file.
    """
    with open(input_file, "rb") as file:
        file_data = file.read()

    encrypted_data = Fernet(
        input("Enter key (master password) to encrypt json file : ")
    ).encrypt(file_data)

    ## Add suffix .enc to our file .json
    output_path = input_file.with_suffix(".enc")
    response = input(
        f"Warning the file {output_path} will be overwritten, continue ? : (y/n)"
    )
    if response.lower() == "y":
        with open(output_path, "wb") as file:
            file.write(encrypted_data)
        # Replace JSON File with encrypted data then remove it
        with open(input_file, "wb") as file:
            file.write(encrypted_data)
            os.remove(input_file)
            print("SHRED UNENCRYPTED FILE")
    else:
        print("Abort")


# Decrypt JSON File
def decrypt_json(file_path: Path):
    with open(file_path, "rb") as file:
        encrypted_data = file.read()

    decrypted_data = Fernet(
        input("Enter key (master password) to decrypt json file : ")
    ).decrypt(encrypted_data)

    return decrypted_data


# Decrypt JSON.enc to JSON File
def decrypt_to_json(input_file: Path):
    with open(input_file, "rb") as file:
        encrypted_data = file.read()

    decrypted_data = Fernet(
        input("Enter key (master password) to decrypt json file : ")
    ).decrypt(encrypted_data)

    ## Add suffix .enc to our file .json
    output_path = input_file.with_suffix(".json")
    response = input(
        f"Warning the file {output_path} will be overwritten, continue ? : (y/n)"
    )
    if response.lower() == "y":
        with open(output_path, "wb") as file:
            file.write(decrypted_data)
        print("MANUALLY SHRED UNENCRYPTED FILE")
    else:
        print("Abort")


## add function to write decode json in file def decrypt_into_file


# # Lire une variable spécifique d'un fichier JSON déchiffré
# def read_variable_from_encrypted_json(file_path: Path, variable_name: str):
#     decrypted_data = decrypt_json(file_path)
#     json_data = json.loads(decrypted_data)

#     # Accéder à la variable spécifique en suivant le chemin de clé
#     keys = variable_name.split(".")
#     data = json_data
#     for key in keys:
#         if key in data:
#             data = data[key]
#         else:
#             raise KeyError(
#                 f"The path '{variable_name}' does not exist in the JSON data."
#             )

#     return data


def main():
    """
    Main function to check for the --generate flag in sys.argv and call generate_content accordingly.
    """
    if "--generate" in sys.argv:
        generate_key()
    if "--decrypt" in sys.argv:
        decrypt_to_json(Path(input("Enter path to file to decrypt : ")))
    if "--encrypt" in sys.argv:
        encrypt_json(Path(input("Enter path to file to encrypt : ")))


if __name__ == "__main__":
    main()
