import 'package:flutter/material.dart';
import 'package:qualaboa/theme/app_theme.dart';
import 'package:qualaboa/models/estabelecimento.dart';
import 'package:qualaboa/services/estabelecimento_service.dart';
import 'package:qualaboa/screens/estabelecimento_detalhes_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Estabelecimento> _estabelecimentos = EstabelecimentoService.getEstabelecimentos();
  
  // Simulando estabelecimentos visitados (usando alguns dos estabelecimentos existentes)
  List<Estabelecimento> get _estabelecimentosVisitados {
    return _estabelecimentos.where((e) => ['1', '3', '5'].contains(e.id)).toList();
  }
  
  // Simulando estabelecimentos favoritos
  List<Estabelecimento> get _estabelecimentosFavoritos {
    return _estabelecimentos.where((e) => ['2', '4'].contains(e.id)).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Seu Histórico',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Lugares que você visitou e seus favoritos',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            // Abas
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppTheme.primaryColor,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey[700],
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: 'Visitados'),
                    Tab(text: 'Favoritos'),
                  ],
                ),
              ),
            ),
            
            // Conteúdo das abas
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Aba de visitados
                  _estabelecimentosVisitados.isEmpty
                      ? _buildEmptyState('Você ainda não visitou nenhum lugar', 'Explore novos lugares e marque-os como visitados')
                      : _buildEstabelecimentosList(_estabelecimentosVisitados),
                  
                  // Aba de favoritos
                  _estabelecimentosFavoritos.isEmpty
                      ? _buildEmptyState('Você ainda não tem favoritos', 'Adicione lugares aos seus favoritos para encontrá-los facilmente')
                      : _buildEstabelecimentosList(_estabelecimentosFavoritos),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Widget para estado vazio
  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  // Widget para lista de estabelecimentos
  Widget _buildEstabelecimentosList(List<Estabelecimento> estabelecimentos) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: estabelecimentos.length,
      itemBuilder: (context, index) {
        final estabelecimento = estabelecimentos[index];
        
        // Data simulada da visita
        final visitDate = DateTime.now().subtract(Duration(days: index * 7 + 3));
        final formattedDate = '${visitDate.day}/${visitDate.month}/${visitDate.year}';
        
        return GestureDetector(
          onTap: () {
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
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Imagem do estabelecimento
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                  child: Image.network(
                    estabelecimento.imagemUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 30, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
                
                // Informações do estabelecimento
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                estabelecimento.nome,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.white, size: 12),
                                  const SizedBox(width: 2),
                                  Text(
                                    estabelecimento.avaliacao.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          estabelecimento.categorias.join(' • '),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text(
                                  'Visitado em $formattedDate',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              _tabController.index == 0 ? Icons.check_circle : Icons.favorite,
                              size: 16,
                              color: _tabController.index == 0 ? Colors.green : Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
