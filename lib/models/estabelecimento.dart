class Estabelecimento {
  final String id;
  final String nome;
  final String endereco;
  final String descricao;
  final String imagemUrl;
  final List<String> categorias;
  final double avaliacao;
  final String horarioFuncionamento;
  final double precoMedio;

  Estabelecimento({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.descricao,
    required this.imagemUrl,
    required this.categorias,
    required this.avaliacao,
    required this.horarioFuncionamento,
    required this.precoMedio,
  });
}
