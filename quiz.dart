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
    'Pergunta': "O que é, o que é: tem cabeça, tem dente, mas não é bicho nem gente?",
    'opcoes': ['Alho', 'Martelo', 'Cebola'],
    'respostaCorreta': 'Alho'
  },
  {
    'Pergunta': "O que é, o que é: quanto mais você tira, maior fica?",
    'opcoes': ['Buraco', 'Corda', 'Sombra'],
    'respostaCorreta': 'Buraco'
  },
  {
    'Pergunta': "O que é, o que é: passa diante do sol e não faz sombra?",
    'opcoes': ['Pensamento', 'Vento', 'Raio-X'],
    'respostaCorreta': 'Vento'
  },
  {
    'Pergunta': "O que é, o que é: sempre cai em pé e corre deitado?",
    'opcoes': ['Água', 'Gato', 'Chuveiro'],
    'respostaCorreta': 'Chuveiro'
  },
  {
    'Pergunta': "O que é, o que é: anda com os pés na cabeça?",
    'opcoes': ['Piolho', 'Cobra', 'Chinelo'],
    'respostaCorreta': 'Piolho'
  },
  {
    'Pergunta': "O que é, o que é: enche uma casa mas não enche uma mão?",
    'opcoes': ['Vento', 'Luz', 'Água'],
    'respostaCorreta': 'Luz'
  },
  {
    'Pergunta': "O que é, o que é: tem nome de gente, mas é planta?",
    'opcoes': ['Jasmim', 'Maria-sem-vergonha', 'Jade'],
    'respostaCorreta': 'Maria-sem-vergonha'
  },
  {
    'Pergunta': "O que é, o que é: é cheio de furos, mas ainda segura água?",
    'opcoes': ['Esponja', 'Balde', 'Peneira'],
    'respostaCorreta': 'Esponja'
  },
  {
    'Pergunta': "O que é, o que é: sobe, mas nunca desce?",
    'opcoes': ['Idade', 'Balão', 'Temperatura'],
    'respostaCorreta': 'Idade'
  },
  {
    'Pergunta': "O que é, o que é: quanto mais se tira, mais aumenta?",
    'opcoes': ['Buraco', 'Divida', 'Tempo'],
    'respostaCorreta': 'Buraco'
  }
];

  late List<Map<String, dynamic>> perguntas;
  int perguntaAtual = 0;
  int pontos = 0;
  String? mensagem;
  bool quizFinalizado = false;

  @override
  void initState() {
    super.initState();
    perguntas = List.from(perguntasOriginais)..shuffle();
  }

  void verificarResposta(String respostaEscolhida) {
    String respostaCorreta = perguntas[perguntaAtual]['respostaCorreta'];

    setState(() {
      if (respostaEscolhida == respostaCorreta) {
        pontos++;
        mensagem = 'Boa seu merda! +1';
      } else {
        mensagem = 'Deixa de ser burro man!';
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
      perguntas = List.from(perguntasOriginais)..shuffle(); // embaralha!
      perguntaAtual = 0;
      pontos = 0;
      quizFinalizado = false;
      mensagem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz flutter'),
        ),
        body: Center(
          child: quizFinalizado
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Boa caramba! Terminou essa merda!',
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
                    Image.network(
                      'https://i.ytimg.com/vi/Fz2vsGm8FzE/maxresdefault.jpg?sqp=-oaymwEoCIAKENAF8quKqQMcGADwAQH4Ab4EgALABIoCDAgAEAEYciBIKEIwDw==&rs=AOn4CLDdo224A7xoHTpQbaFs_msreW_lAA',
                      width: 600,
                      height: 600,
                    ),
                    SizedBox(height: 1),
                    Text(
                      perguntas[perguntaAtual]['Pergunta'],
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 21),
                    ...(perguntas[perguntaAtual]['opcoes'] as List<String>).map<Widget>((opcao) {
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
