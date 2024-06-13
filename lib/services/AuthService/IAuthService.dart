abstract class IAuthService {
  Future<void> registerWithEmailAndPassword(String name,String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}
