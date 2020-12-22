package chang_Byounggil;

import e_oop.ScanUtil;

public class Condition {
	int condition = 70;
	int maxCondition = 100;
	int minCondition = 0;
	int per;
	int eight_fifty;
	int answer;
	String name;
	
	int condition(int a){
		condition += a;
		if(a < 0){
			System.out.println("기분이 "+Math.abs(a)+"만큼 감소했습니다.");
		}
		else{
			System.out.println("기분이 "+Math.abs(a)+"만큼 증가했습니다.");
		}
		return condition;
	}
	int play(){
		
		return condition;
	}
	int eight_twenty() {
		if(condition >0){
			System.out.println("==============================================================");
			System.out.println("1. 나는 무생물이다. 아무것도 안하고 바로 출발(기분 + 0)");
			System.out.println("2. 물 한잔의 여유!! 물 한잔 마시고 기분 좋게 출발(기분 + 5)");
			answer = ScanUtil.nextInt();
			switch(answer){
			case 1 :
				//바로 출발
				per = (int)(Math.random()*101);
				if(per > 20){
					per = (int)(Math.random()*101);
					System.out.println("제 시간에 도착했다.");
					if(per > 50){
						System.out.println("응? 지문인식이 안된다.");
						for(int i = 0; i < 3; i ++){
							try {
								Thread.sleep(400);    //thread에서 0.1초 단위로 한 쪽을 쉬게 하는 메서드이다.
							} catch (InterruptedException e) {
								e.printStackTrace();
							}
							System.out.print(".");
						}
						System.out.println();
						condition(-5);
					}else{
						System.out.println("아무런 일도 일어나지 않았다.");
					}
//				System.out.println();
					break;
				}else{
					System.out.println("정전으로 모든게 멈췄다. 아침부터 허벅지가 파열 될 것 같다.");
					condition(-10);
//				System.out.println();
					break;
				}
			case 2 :
				//물 한잔 마시고 출발.
				per = (int)(Math.random()*101);
//			System.out.println("1 " + per);
				condition(5);
				if(per > 50){
					per = (int)(Math.random()*101);
					System.out.println("제 시간에 도착했다.");
					if(per > 20){
						per = (int)(Math.random()*101);
//					System.out.println("2 " + per);
						System.out.println("응?? 지문인식이 안된다.");
						for(int i = 0; i < 3; i ++){
							try {
								Thread.sleep(400);    //thread에서 0.1초 단위로 한 쪽을 쉬게 하는 메서드이다.
							} catch (InterruptedException e) {
								e.printStackTrace();
							}
							System.out.print(".");
						}
						System.out.println();
						System.out.println("결국 지각했다... 기분이 나빠진다.");
						condition(-20);
					}
//				System.out.println();
					break;
				}else{
					System.out.print("늦었다");
					for(int i = 0; i < 3; i ++){
						try {
							Thread.sleep(400);    //thread에서 0.1초 단위로 한 쪽을 쉬게 하는 메서드이다.
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
						System.out.print(".");
					}
					System.out.println();
					System.out.println("5000원짜리 물 한잔이었다. 아프리카도 아니고");
					condition(-20);
//				System.out.println();
					break;
				}
			}
		}
		return condition;
	}
	int eight_fifty(){
		System.out.println("==============================================================");
		System.out.println("1. 물 뜨러가기"+"\t"+ "2. 화장실 가기"+"\t"+"3. 교실에 머물기");
		answer = ScanUtil.nextInt();
		per = (int)(Math.random()*101);
		switch(answer){
			case 1:
				if(per > 80){
					System.out.println("... 정수기가 고장났다.");
					System.out.println("커피를 못마신다 생각하니 눈앞이 깜깜하다.");
					condition(-20);
				}else{
					System.out.println("따뜻한 물을 마신다고 생각하니 기분이 좋아진다.");
					condition(5);
				}
				break;
			case 2:
				System.out.print("쏴아아");
				
				for(int i = 0; i < 3; i ++){
					try {
						Thread.sleep(200);    //thread에서 0.1초 단위로 한 쪽을 쉬게 하는 메서드이다.
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
					System.out.print(".");
				}
				System.out.println();
				per = (int)(Math.random()*101);
				if(per < 51){
					System.out.println("억... 물이 뼈까지 시리다.");
					condition(-5);
				}
				else{
					System.out.println("시원한 물에 손을 씻으니 기분이 좋아진다");
					condition(5);					
				}
				break;
			case 3:
				per = (int)(Math.random()*101);
				if(per <=50){
					System.out.println("\"빨리 포기해\"");
					System.out.println("\"매일 영문타자 치라고 했죠\"");
					System.out.println("\"지각 하면...\"");
					System.out.println("귀에서 피가 난다. 극심한 스트레스를 받았다.");
					condition(-30);					
				}else{
					System.out.println("\"빨리 포*해\"");
					System.out.println("\"제가 매일 영문** 치라*... \"");
					System.out.println("\"*각 **...\"");
					System.out.println("오늘은 이어폰을 들고왔다. 다행이다. 조금 더 소리를 키워볼까?^^");
					condition(5);
				}
				break;
		}
		return condition;
	}
	//수업듣기
	int ten(){
		System.out.println("==============================================================");
		System.out.println("1. 수업듣기"+"\t"+ "2. 딴짓하기");
		answer = ScanUtil.nextInt();
		per = (int)(Math.random()*101);
		switch(answer){
			case 1: if(per < 31){
						System.out.println("열심히 수업을 들었다. 뿌듯하다");
						condition(5);
						break;
					}else{
						for(int i = 0; i < 3; i ++){
							try {
								Thread.sleep(200);    //thread에서 0.1초 단위로 한 쪽을 쉬게 하는 메서드이다.
							} catch (InterruptedException e) {
								e.printStackTrace();
							}
							System.out.print(".");
						}
						System.out.println();
						System.out.println("딴짓을 하고픈 유혹이 든다.");
						ten_fd(); // 딴짓 유혹하기
						break;
					}
			case 2: ten_sd(); break;
		}
		return condition;
	}
	//딴짓 유혹
//	(int)(Math.random()*(20-10+1))+10;
	void ten_fd(){
		System.out.println("1. 잠깐 딴 짓을 해볼까?\t 2. 아니야 열심히 수업을 듣자");
		answer = ScanUtil.nextInt();
		switch(answer){
		case 1: ten_sd(); break;
		case 2: per = (int)(Math.random()*101);
				if(per < 30){
					System.out.println("... 정말로...?");
					ten_fd();
				}else if(per < 81){
					System.out.println("헉! 졸아버렸다. 기분이 나빠졌다");
					condition(-15); break;
				}else{
					System.out.println("유혹에도 불구하고 열심히 수업을 들었다. 기분이 뿌듯하다.");
					condition(5); break;
				}
				
		}
	}
	void ten_sd(){
		System.out.println("흠... 어쩌지??");
		System.out.println("1. 게임하기\t 2. 아니야 정신차리고 수업이나 듣자");
		answer = ScanUtil.nextInt();
		switch(answer){
		case 1: game(condition, name); 
				
				break;
		case 2: per = (int)(Math.random()*101);
				if(per < 51){
					System.out.println("헉! 졸아버렸다. 기분이 나빠졌다");
					condition(-15); break;
				}
				System.out.println("유혹에도 불구하고 열심히 수업을 들었다. 기분이 뿌듯하다.");
				condition(10); break;
		}
	}
	//게임
	void game(int condition, String name){
		 Character c = new Character(name, condition);
		 Monster m = new Monster(condition, "괴물");
		 System.out.println("==========상태창==========");
		 System.out.println("이름 : " + c.name);
		 System.out.println("HP: "+c.hp);
		 System.out.println("att: "+c.att);
		 System.out.println("def: "+c.def);
		 System.out.println("========================");
		 System.out.println(m.name+"이 나타났다. 전투를 시작한다.");
		 System.out.println("==========상태창==========");
		 System.out.println("이름 : " +m.name);
		 System.out.println("HP: "+m.hp);
		 System.out.println("att: "+m.att);
		 System.out.println("def: "+m.def);
		 System.out.println("========================");
		 int input = 0;
			battle : while(true){ //이런식으로도 쓸 수 있음 이름 명명
				System.out.println("1.공격\t");
				input = ScanUtil.nextInt();
				switch(input){
				case 1:
					c.attack(m);
					if(m.hp <= 0){
						System.out.println(m.name + "을 처치하였습니다.");
						System.out.println("훗 기분이 조금 좋아졌다.");
						condition(5);
						afterGame();
						break battle;
					}
					m.attack(c);
					if(c.hp <= 0){
						System.out.println(c.name + "는 사망하였습니다.");
						for(int i =0; i < 3; i ++){
							System.out.print(".");
							try {
								Thread.sleep(200);    //thread에서 0.1초 단위로 한 쪽을 쉬게 하는 메서드이다.
							} catch (InterruptedException e) {
								e.printStackTrace();
							}
						}
						System.out.println();
						condition(-5);
						afterGame();
						break battle;
					}
					break;
				case 2:
					break battle;
				}
			}	
	}
	void afterGame(){
		per = (int)(Math.random()*101);
		if(per < 71){
			for(int i = 0; i < 3; i ++){
				try {
					Thread.sleep(200);    //thread에서 0.1초 단위로 한 쪽을 쉬게 하는 메서드이다.
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				System.out.print(".");
			}
			System.out.println("수업 진도를 놓쳤다. 나 자신에게 회의감이 든다.");
			condition(-10);
		}else{
			for(int i = 0; i < 3; i ++){
				try {
					Thread.sleep(200);    //thread에서 0.1초 단위로 한 쪽을 쉬게 하는 메서드이다.
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				System.out.print(".");
			}
			System.out.println("latte 얘기를 하고 계신다. 진도를 놓치지 않아 다행이다.");
		}
	}
	//마지막
	int sixteen(){
		System.out.println("1. 집에가기\t 2. 남아서 공부하기");
		answer = ScanUtil.nextInt();
		per = (int)(Math.random()*101);
		switch(answer){
		case 1: System.out.println("집에가서 운동하고 부족한 부분에 대해 공부했다."); 
				System.out.println("오늘 하루를 건강하게 잘 마무리 한 기분이다.");
				condition(20);
				break;
		case 2: if(per < 30){
					System.out.println("오늘따라 집중이 잘 된다.");
					System.out.println("뿌듯하다...");
					condition(10); break;
				}else if(per < 70){
					System.out.println("...무언가 한 것 같은데");
					System.out.println("...한 것 같지가 않다");
					break;
				}else{
					System.out.println("졸았다. 그냥 잠이 온다. 왜 남아서 공부했나 싶다.");
					System.out.println("하루가 회의적이다.");
					condition(-10);
					break;
				}
		}
		return condition;
	}
	//마무리
	void last(){
		if (condition > 69){
			System.out.println("하루를 충만하게 보낸 기분이 든다.");
			System.out.println("내일도 힘차고 보람찬 하루를 보낼 수 있을 것 같은 자신감이 든다.");
			System.out.println("나 자신에게 확고한 믿음이 생긴다.");
		}
		else if(condition > 39){
			System.out.println("하루를 평범하게 보낸 기분이 든다.");
			System.out.println("내일을 위해 힘을 내보아야 겠다.");
		}else{
			System.out.println("... 최악의 날이다. 인생이 너무나도 힘겹다.");
			System.out.println("그래도... 내일은 다를거라는 믿음을 가져본다.");
		}
	}
}
