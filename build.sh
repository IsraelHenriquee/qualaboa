#!/bin/bash

# Instalar Flutter
echo "Baixando Flutter..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1

# Adicionar Flutter ao PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verificar instalação do Flutter
flutter --version

# Habilitar Flutter web
flutter config --enable-web

# Construir o projeto Flutter para web
echo "Construindo o projeto Flutter para web..."
flutter build web --release

# Mover os arquivos para o diretório correto (opcional, dependendo da configuração)
# cp -R build/web/* public/

echo "Build concluída com sucesso!"
