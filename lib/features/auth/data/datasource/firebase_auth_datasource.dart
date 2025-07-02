import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';
import 'auth_datasource.dart';

class FirebaseAuthDataSource implements AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserEntity> register(String name, String cpf, String password) async {
    final email = '$cpf@app.com';

    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = result.user?.uid;
      if (uid == null) throw Exception('UID do usuário é nulo');

      print('FirebaseAuth: UID criado $uid');

      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'cpf': cpf,
        'email': email,
      }).timeout(const Duration(seconds: 5));

      print('Firestore: Dados gravados com sucesso');

      return UserEntity(uid: uid, cpf: cpf, name: name, email: email);
    } catch (e, stack) {
      print('❌ Erro no registro: $e');
      print(stack);
      rethrow;
    }
  }

  @override
  Future<UserEntity> login(String cpf, String password) async {
    final email = '$cpf@app.com';

    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = result.user!.uid;
    final doc = await _firestore.collection('users').doc(uid).get();

    return UserEntity(
      uid: uid,
      cpf: doc['cpf'],
      name: doc['name'],
      email: doc['email'],
    );
  }

  @override
  Future<UserEntity> getLoggedUser() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Usuário não logado');

    final doc = await _firestore.collection('users').doc(user.uid).get();

    return UserEntity(
      uid: user.uid,
      cpf: doc['cpf'],
      name: doc['name'],
      email: doc['email'],
    );
  }
}
