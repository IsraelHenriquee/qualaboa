import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qualaboa/models/estabelecimento.dart';
import 'package:qualaboa/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class EstabelecimentoDetalhesScreen extends StatefulWidget {
  final Estabelecimento estabelecimento;

  const EstabelecimentoDetalhesScreen({
    super.key,
    required this.estabelecimento,
  });

  @override
  State<EstabelecimentoDetalhesScreen> createState() => _EstabelecimentoDetalhesScreenState();
}

class _EstabelecimentoDetalhesScreenState extends State<EstabelecimentoDetalhesScreen> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();
  
  // Coordenadas simuladas para cada estabelecimento (latitude, longitude)
  List<double> _getCoordinates() {
    switch (widget.estabelecimento.id) {
      case '1':
        return [-23.5505, -46.6333]; // São Paulo
      case '2':
        return [-23.5630, -46.6543]; // Av. Paulista
      case '3':
        return [-23.5577, -46.6409]; // Consolação
      case '4':
        return [-23.5632, -46.6909]; // Pinheiros
      case '5':
        return [-23.5677, -46.6695]; // Jardins
      case '6':
        return [-23.5553, -46.6353]; // Liberdade
      default:
        return [-23.5505, -46.6333]; // São Paulo
    }
  }
  
  // Obter o endereço formatado para exibição
  String _getEnderecoFormatado() {
    return widget.estabelecimento.endereco;
  }
  
  @override
  void initState() {
    super.initState();
  }

  // Simulando múltiplas imagens para o estabelecimento
  List<String> _getImagens() {
    switch (widget.estabelecimento.id) {
      case '1': // Bar do Zé
        return [
          widget.estabelecimento.imagemUrl,
          'https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1583227122027-d2d360c66d3c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1543007630-9710e4a00a20?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ];
      case '2': // Clube Disco
        return [
          widget.estabelecimento.imagemUrl,
          'https://images.unsplash.com/photo-1571204829887-3b8d69e4094d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1545128485-c400e7702796?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1581974944026-5d6ed762f617?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ];
      case '3': // Boteco Carioca
        return [
          widget.estabelecimento.imagemUrl,
          'https://images.unsplash.com/photo-1438557068880-c5f474830377?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1525268323446-0505b6fe7778?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ];
      case '4': // Samba & Cia
        return [
          widget.estabelecimento.imagemUrl,
          'https://images.unsplash.com/photo-1504609773096-104ff2c73ba4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1563841930606-67e2bce48b78?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ];
      case '5': // Pub Inglês
        return [
          widget.estabelecimento.imagemUrl,
          'https://images.unsplash.com/photo-1546726747-421c6d69c929?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1566417713940-fe7c737a9ef2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ];
      case '6': // Karaokê Nippon
        return [
          widget.estabelecimento.imagemUrl,
          'https://images.unsplash.com/photo-1559070169-a3077159ee16?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1559070165-d747c6e2517b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ];
      default:
        return [
          widget.estabelecimento.imagemUrl,
          'https://images.unsplash.com/photo-1566417713940-fe7c737a9ef2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ];
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imagens = _getImagens();
    final estabelecimento = widget.estabelecimento;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar com imagem e botão de voltar
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Carrossel de imagens
                  PageView.builder(
                    controller: _pageController,
                    itemCount: imagens.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: imagens[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        ),
                      );
                    },
                  ),
                  
                  // Gradiente para melhorar a visibilidade dos elementos
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  
                  // Indicadores de página
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imagens.asMap().entries.map((entry) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == entry.key
                                ? AppTheme.primaryColor
                                : Colors.white.withOpacity(0.5),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          
          // Conteúdo principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome e avaliação
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          estabelecimento.nome,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              estabelecimento.avaliacao.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Categorias
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: estabelecimento.categorias.map((categoria) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          categoria,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Seção de informações
                  _buildInfoSection('Sobre', estabelecimento.descricao),
                  
                  _buildInfoSection(
                    'Endereço',
                    estabelecimento.endereco,
                    icon: Icons.location_on,
                  ),
                  
                  _buildInfoSection(
                    'Horário de Funcionamento',
                    estabelecimento.horarioFuncionamento,
                    icon: Icons.access_time,
                  ),
                  
                  // Pessoas que confirmaram presença
                  const SizedBox(height: 8),
                  const Text(
                    'Quem vai estar lá',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Número de pessoas confirmadas
                        Row(
                          children: [
                            Icon(Icons.people, color: AppTheme.primaryColor),
                            const SizedBox(width: 8),
                            Text(
                              '${_getNumeroConfirmados()} pessoas confirmaram presença',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Fotos de perfil
                        Row(
                          children: [
                            // Fotos de perfil empilhadas
                            SizedBox(
                              height: 60,
                              width: 200, // Largura fixa para evitar overflow
                              child: Stack(
                                children: _getFotosPerfilConfirmados().asMap().entries.map((entry) {
                                  final int idx = entry.key;
                                  final String url = entry.value;
                                  // Limitar o número de fotos visíveis para evitar overflow
                                  if (idx > 5) return const SizedBox.shrink();
                                  
                                  return Positioned(
                                    left: idx * 25.0,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[300],
                                        border: Border.all(color: Colors.white, width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.network(
                                          url,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Center(
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded / 
                                                          loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Center(
                                              child: Icon(Icons.person, color: Colors.grey),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Botão para confirmar presença
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Aqui poderia ter a lógica para confirmar presença
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Presença confirmada!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.check_circle_outline),
                                label: const Text('Confirmar presença'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Endereço e botão para abrir no Google Maps
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            estabelecimento.endereco,
                            style: TextStyle(color: Colors.grey[800]),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            _abrirNoGoogleMaps();
                          },
                          icon: const Icon(Icons.directions, size: 16),
                          label: const Text('Como chegar'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Estilo de música (simulado)
                  _buildInfoSection(
                    'Estilo de Música',
                    _getEstiloMusica(estabelecimento.id),
                    icon: Icons.music_note,
                  ),

                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Método para construir seções de informação
  Widget _buildInfoSection(String title, String content, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
  
  // Método para simular estilos de música baseados no ID
  String _getEstiloMusica(String id) {
    switch (id) {
      case '1':
        return 'MPB, Rock Nacional, Samba';
      case '2':
        return 'Eletrônica, House, Techno';
      case '3':
        return 'MPB, Samba, Pagode';
      case '4':
        return 'Samba, Pagode, Samba-rock';
      case '5':
        return 'Rock Clássico, Blues, Jazz';
      case '6':
        return 'Pop Internacional, J-Pop, K-Pop';
      default:
        return 'Variado';
    }
  }
  
  // Simulando o número de pessoas que confirmaram presença
  int _getNumeroConfirmados() {
    switch (widget.estabelecimento.id) {
      case '1':
        return 15;
      case '2':
        return 42;
      case '3':
        return 8;
      case '4':
        return 27;
      case '5':
        return 19;
      case '6':
        return 31;
      default:
        return 12;
    }
  }
  
  // Simulando fotos de perfil de pessoas que confirmaram presença
  List<String> _getFotosPerfilConfirmados() {
    // Fotos de perfil genéricas para simular pessoas que confirmaram presença
    // Usando imagens do Unsplash que são mais confiáveis
    final List<String> fotosGenericas = [
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
      'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
      'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
      'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
      'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
      'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80',
    ];
    
    // Retorna um número diferente de fotos com base no ID do estabelecimento
    int numFotos = 0;
    switch (widget.estabelecimento.id) {
      case '1':
        numFotos = 5;
        break;
      case '2':
        numFotos = 8;
        break;
      case '3':
        numFotos = 3;
        break;
      case '4':
        numFotos = 6;
        break;
      case '5':
        numFotos = 4;
        break;
      case '6':
        numFotos = 7;
        break;
      default:
        numFotos = 4;
    }
    
    // Garantir que não tentamos acessar mais fotos do que existem na lista
    numFotos = numFotos > fotosGenericas.length ? fotosGenericas.length : numFotos;
    return fotosGenericas.sublist(0, numFotos);
  }
  
  // Método para abrir o Google Maps com a localização do estabelecimento
  void _abrirNoGoogleMaps() async {
    final coords = _getCoordinates();
    final url = 'https://www.google.com/maps/search/?api=1&query=${coords[0]},${coords[1]}';
    
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Não foi possível abrir o Google Maps'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao abrir o mapa: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
