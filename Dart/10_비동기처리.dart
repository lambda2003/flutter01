

main() {

  
  checkVersion1();  // 처리
  print('동기 ========');
  checkVersion(); // 비동기 처리
  print('end process ====');
}

// 비동기 방식
checkVersion() async {
  int version = await lookUpVersion();
  print(version);
}

int lookUpVersion() {
  return 12;
}

// 동기 방식
checkVersion1() {
  int version =  lookUpVersion();
  print(version);
}

int lookUpVersion1() {
  return 12;
}