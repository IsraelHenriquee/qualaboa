import 'package:flutter/material.dart';
import 'package:qualaboa/models/estabelecimento.dart';
import 'package:qualaboa/services/estabelecimento_service.dart';
import 'package:qualaboa/widgets/categoria_chip.dart';
import 'package:qualaboa/widgets/estabelecimento_card.dart';
import 'package:qualaboa/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qualaboa/screens/estabelecimento_detalhes_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Estabelecimento> _estabelecimentos = EstabelecimentoService.getEstabelecimentos();
  final List<String> _categorias = EstabelecimentoService.getCategorias();
  final TextEditingController _searchController = TextEditingController();
  String _categoriaSelecionada = '';
  List<Estabelecimento> _estabelecimentosFiltrados = [];
  
  // Lista de categorias com ícones conforme a imagem
  final List<Map<String, dynamic>> _categoriasComIcones = [
    {'nome': 'Bar', 'icone': Icons.sports_bar, 'display': 'Bares'},
    {'nome': 'Balada', 'icone': Icons.music_note, 'display': 'Baladas'},
    {'nome': 'Cultura', 'icone': Icons.theater_comedy, 'display': 'Cultura'},
    {'nome': 'Day Party', 'icone': Icons.wb_sunny, 'display': 'Day Party'},
    {'nome': 'Gastronomia', 'icone': Icons.restaurant, 'display': 'Gastronomia'},
    {'nome': 'Música ao vivo', 'icone': Icons.headphones, 'display': 'Shows'},
    {'nome': 'Samba', 'icone': Icons.star, 'display': 'Festas Exclusivas'},
  ];

  @override
  void initState() {
    super.initState();
    _estabelecimentosFiltrados = _estabelecimentos;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filtrarEstabelecimentos() {
    setState(() {
      _estabelecimentosFiltrados = _estabelecimentos.where((estabelecimento) {
        // Filtro por texto de busca
        final matchesSearch = _searchController.text.isEmpty ||
            estabelecimento.nome.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            estabelecimento.descricao.toLowerCase().contains(_searchController.text.toLowerCase());

        // Filtro por categoria
        final matchesCategoria = _categoriaSelecionada.isEmpty ||
            estabelecimento.categorias.contains(_categoriaSelecionada);

        return matchesSearch && matchesCategoria;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho com logo e localização
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  // Logo de cerveja
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.sports_bar,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Título do app
                  const Text(
                    'Qual é a Boa?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            
            // Localização
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppTheme.primaryColor,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Curitiba',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            
            // Campo de busca
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => _filtrarEstabelecimentos(),
                decoration: InputDecoration(
                  hintText: 'Procurar eventos, bares ou baladas...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            
            // Categorias com ícones
            Container(
              height: 80,
              margin: const EdgeInsets.only(top: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categoriasComIcones.length,
                itemBuilder: (context, index) {
                  final categoria = _categoriasComIcones[index];
                  final isSelected = _categoriaSelecionada == categoria['nome'];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        // Ícone da categoria
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_categoriaSelecionada == categoria['nome']) {
                                _categoriaSelecionada = '';
                              } else {
                                _categoriaSelecionada = categoria['nome'];
                              }
                              _filtrarEstabelecimentos();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected ? AppTheme.primaryColor : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              categoria['icone'],
                              color: isSelected ? Colors.white : AppTheme.primaryColor,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Nome da categoria
                        Text(
                          categoria['display'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppTheme.primaryColor : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Espaçamento entre categorias e lista de estabelecimentos
            const SizedBox(height: 16),
            
            // Lista de estabelecimentos
            Expanded(
              child: _estabelecimentosFiltrados.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum estabelecimento encontrado',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _estabelecimentosFiltrados.length,
                      itemBuilder: (context, index) {
                        final estabelecimento = _estabelecimentosFiltrados[index];
                        return _buildEstabelecimentoItem(estabelecimento);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Método para construir um item de estabelecimento no estilo da imagem
  Widget _buildEstabelecimentoItem(Estabelecimento estabelecimento) {
    return GestureDetector(
      onTap: () {
        // Navega para a tela de detalhes do estabelecimento
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EstabelecimentoDetalhesScreen(
              estabelecimento: estabelecimento,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem do estabelecimento
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: estabelecimento.imagemUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  memCacheHeight: 500,
                  memCacheWidth: 500,
                  fadeInDuration: const Duration(milliseconds: 300),
                  httpHeaders: const {"Accept": "image/*"},
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.image_not_supported, color: Colors.grey),
                        const SizedBox(height: 4),
                        Text(
                          'Imagem indisponível',
                          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Nome do estabelecimento
            Text(
              estabelecimento.nome,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Horário
            Text(
              'Hoje, às ${estabelecimento.horarioFuncionamento.split(' - ')[0]}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            // Botão de destaque ou categoria
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: int.parse(estabelecimento.id) % 2 == 0 ? AppTheme.primaryColor : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                int.parse(estabelecimento.id) % 2 == 0 ? 'Mais procurado' : estabelecimento.categorias.first,
                style: TextStyle(
                  fontSize: 12,
                  color: int.parse(estabelecimento.id) % 2 == 0 ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
