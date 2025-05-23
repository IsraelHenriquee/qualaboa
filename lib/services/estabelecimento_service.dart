import 'package:qualaboa/models/estabelecimento.dart';

class EstabelecimentoService {
  // Simulando dados que viriam de uma API
  static List<Estabelecimento> getEstabelecimentos() {
    return [
      Estabelecimento(
        id: '1',
        nome: 'Bar do Zé',
        endereco: 'Rua Augusta, 1200 - Consolação',
        descricao: 'Bar tradicional com música ao vivo e petiscos variados.',
        imagemUrl: 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        categorias: ['Bar', 'Música ao vivo', 'Petiscos'],
        avaliacao: 4.5,
        horarioFuncionamento: '18:00 - 02:00',
        precoMedio: 80.0,
      ),
      Estabelecimento(
        id: '2',
        nome: 'Clube Disco',
        endereco: 'Av. Paulista, 900 - Bela Vista',
        descricao: 'Balada com DJs internacionais e pista de dança espaçosa.',
        imagemUrl: 'https://images.unsplash.com/photo-1566737236500-c8ac43014a67?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        categorias: ['Balada', 'Eletrônica', 'DJ'],
        avaliacao: 4.8,
        horarioFuncionamento: '23:00 - 06:00',
        precoMedio: 150.0,
      ),
      Estabelecimento(
        id: '3',
        nome: 'Boteco Carioca',
        endereco: 'Rua da Consolação, 3456 - Jardins',
        descricao: 'Ambiente descontraído com cerveja gelada e tira-gostos.',
        imagemUrl: 'https://images.unsplash.com/photo-1555658636-6e4a36218be7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        categorias: ['Boteco', 'Cerveja artesanal', 'Petiscos'],
        avaliacao: 4.2,
        horarioFuncionamento: '17:00 - 01:00',
        precoMedio: 60.0,
      ),
      Estabelecimento(
        id: '4',
        nome: 'Samba & Cia',
        endereco: 'Rua dos Pinheiros, 789 - Pinheiros',
        descricao: 'Casa de samba com roda de samba ao vivo e feijoada aos sábados.',
        imagemUrl: 'https://images.unsplash.com/photo-1535359056830-d4badde79747?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        categorias: ['Samba', 'Música ao vivo', 'Comida brasileira'],
        avaliacao: 4.7,
        horarioFuncionamento: '19:00 - 03:00',
        precoMedio: 100.0,
      ),
      Estabelecimento(
        id: '5',
        nome: 'Pub Inglês',
        endereco: 'Rua Oscar Freire, 2345 - Jardins',
        descricao: 'Pub com ambiente britânico, cervejas importadas e jogos de dardos.',
        imagemUrl: 'https://images.unsplash.com/photo-1575444758702-4a6b9222336e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        categorias: ['Pub', 'Cerveja importada', 'Jogos'],
        avaliacao: 4.4,
        horarioFuncionamento: '16:00 - 02:00',
        precoMedio: 120.0,
      ),
      Estabelecimento(
        id: '6',
        nome: 'Karaokê Nippon',
        endereco: 'Rua Liberdade, 456 - Liberdade',
        descricao: 'Karaokê com salas privativas e cardápio de comida japonesa.',
        imagemUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        categorias: ['Karaokê', 'Comida japonesa', 'Salas privativas'],
        avaliacao: 4.3,
        horarioFuncionamento: '18:00 - 04:00',
        precoMedio: 90.0,
      ),
    ];
  }

  static List<String> getCategorias() {
    return [
      'Bar',
      'Balada',
      'Boteco',
      'Pub',
      'Karaokê',
      'Samba',
      'Música ao vivo',
      'DJ',
      'Cerveja artesanal',
      'Cerveja importada',
      'Comida brasileira',
      'Comida japonesa',
      'Petiscos',
      'Jogos',
    ];
  }
}
