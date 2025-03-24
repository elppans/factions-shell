#!/bin/bash

#!/bin/bash

# Função para instalar um pacote usando o gerenciador de pacotes disponível
#!/bin/bash

# Função para verificar e instalar pacotes
instalar_pacote() {
    local PACKAGE="$1"

    if command -v apt > /dev/null; then
        sudo apt update
        sudo apt install -y "$PACKAGE"
    elif command -v pacman > /dev/null; then
        sudo pacman -Sy "$PACKAGE" --noconfirm
    elif command -v yum > /dev/null; then
        sudo yum install -y "$PACKAGE"
    elif command -v dnf > /dev/null; then
        sudo dnf install -y "$PACKAGE"
    else
        echo "Nenhum gerenciador de pacotes compatível encontrado."
        exit 1
    fi
}

# Verificar e instalar pacotes necessários
for CMD in gtkhash file-roller xterm; do
    if ! command -v "$CMD" > /dev/null; then
        instalar_pacote "$CMD"
    fi
done


LOCAL_BIN="usr/local/bin"
ACTION_DIR="$HOME/.local/share/nautilus/scripts"
ACTION_TOOLS="factions-shell"

# Crie o diretório de scripts do Nautilus no diretório do usuário se não existir
mkdir -p "$ACTION_DIR"

# Copie o diretório de ferramentas Action Scripts para o diretório de Scripts
cp -rf "$ACTION_TOOLS"/* "$ACTION_DIR"

# Torne o script de conversão executável
chmod +x "$ACTION_DIR"/"$ACTION_TOOLS"/*/*

# Copie os binários para o sistema
cd "$LOCAL_BIN"
sudo cp -a * "/$LOCAL_BIN"

# Reinicie o Nautilus para aplicar as mudanças
nautilus -q

echo "Configuração concluída. As ações 'El-Images' foi adicionada ao menu de contexto do Nautilus."
