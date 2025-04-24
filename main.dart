import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, dynamic>> perguntasOriginais = [
    {
      'Pergunta': "Em que ano o Ceará Sporting Club foi fundado?",
      'opcoes': ['1914', '1915', '1920'],
      'respostaCorreta': '1914',
      'imagem': 'https://tse3.mm.bing.net/th?id=OIF.HVty30f0qfxSfqhF5Pnw8A&pid=Api&P=0&h=180'
    },
    {
      'Pergunta': "Qual o apelido mais conhecido do Ceará?",
      'opcoes': ['Vovô', 'Leão', 'Galo'],
      'respostaCorreta': 'Vovô',
      'imagem': 'https://tse4.mm.bing.net/th?id=OIF.5mWnGccaz6F9aDskCg42YQ&pid=Api&P=0&h=180'
    },
    {
      'Pergunta': "Qual estádio o Ceará usa como principal mando de campo?",
      'opcoes': ['Arena Castelão', 'Estádio Presidente Vargas', 'Romeirão'],
      'respostaCorreta': 'Arena Castelão',
      'imagem': 'https://tse4.mm.bing.net/th?id=OIP.odgy4kG5CPh_O8iFdfmQ3AHaFj&pid=Api&P=0&h=180'
    },
    {
      'Pergunta': "Contra qual time é disputado o Clássico-Rei?",
      'opcoes': ['Fortaleza', 'Ferroviário', 'Bahia'],
      'respostaCorreta': 'Fortaleza',
      'imagem': 'https://tse1.mm.bing.net/th?id=OIP._0dt_phCZiEX1tZEnaog9AHaEN&pid=Api&P=0&h=180'
    },
    {
      'Pergunta': "Quantos títulos da Copa do Nordeste o Ceará possui até 2024?",
      'opcoes': ['2', '1', '4'],
      'respostaCorreta': '2',
      'imagem': 'https://i.pinimg.com/736x/01/b5/12/01b5122ecf224083c71183efc1382208.jpg'
    },
    {
      'Pergunta': "Qual destas é uma torcida organizada do Ceará?",
      'opcoes': ['Cearamor', 'Tricolores', 'Galoucura'],
      'respostaCorreta': 'Cearamor',
      'imagem': 'https://cidadeolimpica.com.br/wp-content/uploads/2020/09/ceara-wallpaper-pc-scaled.jpg'
    },
    {
      'Pergunta': "Quem é o maior artilheiro da história do Ceará?",
      'opcoes': ['Sérgio Alves', 'Magno Alves', 'Mota'],
      'respostaCorreta': 'Sérgio Alves',
      'imagem': 'https://tse1.mm.bing.net/th?id=OIP.OYw6TfaJiKtGoj5Pbm58DgHaHa&pid=Api&P=0&h=180'
    },
    {
      'Pergunta': "Qual dessas cores está presente no uniforme do Ceará?",
      'opcoes': ['Preto e branco', 'Verde e amarelo', 'Azul e branco'],
      'respostaCorreta': 'Preto e branco',
      'imagem': 'https://cassiozirpoli.com.br/wp-content/uploads/2023/04/uniforme_ceara_2023_camisa_1_700_1.jpg'
    },
    {
      'Pergunta': "Qual foi a melhor campanha do Ceará no Brasileirão Série A até 2024?",
      'opcoes': ['11º lugar', '7º lugar', '5º lugar'],
      'respostaCorreta': '7º lugar',
      'imagem': 'https://tse3.mm.bing.net/th?id=OIP.yeLJQnAgR2AzNhC5pUQXrAHaEo&pid=Api&P=0&h=180'
    },
    {
      'Pergunta': "Em 2021, o Ceará participou de qual competição internacional?",
      'opcoes': ['Copa Sul-Americana', 'Libertadores', 'Champions League'],
      'respostaCorreta': 'Copa Sul-Americana',
      'imagem': 'https://www.opovo.com.br/_midias/jpg/2025/04/18/995x663/1_fabiano_souza_lateral_ceara_vasco_jogo_brasileirao_serie_a_2025-34092202.jpg'
    },
  ];

  late List<Map<String, dynamic>> perguntas;
  int perguntaAtual = 0;
  int pontos = 0;
  String? mensagem;
  bool quizFinalizado = false;

  @override
  void initState() {
    super.initState();
    perguntas = List.from(perguntasOriginais)..shuffle(); // Embaralha perguntas
  }

  void verificarResposta(String respostaEscolhida) {
    String respostaCorreta = perguntas[perguntaAtual]['respostaCorreta'];

    setState(() {
      if (respostaEscolhida == respostaCorreta) {
        pontos++;
        mensagem = 'Parabéns! Você acertou!';
      } else {
        mensagem = 'Que pena! Você errou!';
      }
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        mensagem = null;
        if (perguntaAtual < perguntas.length - 1) {
          perguntaAtual++;
        } else {
          quizFinalizado = true;
        }
      });
    });
  }

  void reiniciarQuiz() {
    setState(() {
      perguntas = List.from(perguntasOriginais)..shuffle(); // Reembaralha perguntas
      perguntaAtual = 0;
      pontos = 0;
      quizFinalizado = false;
      mensagem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final perguntaAtualData = perguntas[perguntaAtual];

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz Flutter'),
        ),
        body: Center(
          child: quizFinalizado
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Parabéns! Você concluiu o quiz!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 26),
                    ),
                    SizedBox(height: 24),
                    Text('Sua pontuação foi: $pontos/${perguntas.length}'),
                    SizedBox(height: 21),
                    ElevatedButton(
                      onPressed: reiniciarQuiz,
                      child: Text('Recomeçar'),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (perguntaAtualData.containsKey('imagem'))
                      Image.network(
                        perguntaAtualData['imagem'],
                        width: 600,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(height: 10),
                    Text(
                      perguntaAtualData['Pergunta'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    ...(perguntaAtualData['opcoes'] as List<String>).map<Widget>((opcao) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                          onPressed: mensagem == null ? () => verificarResposta(opcao) : null,
                          child: Text(opcao),
                        ),
                      );
                    }).toList(),
                    if (mensagem != null) ...[
                      SizedBox(height: 20),
                      Text(
                        mensagem!,
                        style: TextStyle(fontSize: 18, color: Colors.amber),
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}