package chang_Byounggil;

import e_oop.ScanUtil;

public class Starcraft_recruit {
	Starcraft unit = new Starcraft();
	Marine[] t_marine = new Marine[3];
	SCV[] t_SCV = new SCV[3];
	Tank[] t_Tank = new Tank[3];
	Dropship[] t_Dropship = new Dropship[3];
	Money money = new Money();
	int income;
	int mining_count;
	int life;
	int goal_M;
	int goal_T;
	int goal_D;
	void recruit(){
		life = 3;
		System.out.println("1. 보유자원이 50원 아래로 내려가게 하지 마십시오. 내려갈때마다 생명이 1씩 내려갑니다. 현재 생명 3");
		System.out.println("2. SCV 한명당 한 턴에 10원의 income이 들어옵니다. 최대 30원");
		System.out.println("3. MINING은 총 10번 사용할 수 있습니다. MINING 사용 시 SCV 보유 수*10- 만큼 돈이 들어옵니다.");
		goal_M = (int)(Math.random()*3)+1;
		goal_T = (int)(Math.random()*2);
		goal_D = (int)(Math.random()*2)+1;
		
		recruit : while(true){
			
			System.out.println("Marine "+goal_M+"명, "+"Tank "+goal_T+"대, "+"Dropship "+goal_D+"대를 모집하십시오.");
			System.out.println("===================================================================================");
			System.out.print("생명 : ");
			for(int i = 0; i < 3; i++){
				if(i<life){
					System.out.print("♥");
				}
				else{
					System.out.print("♡");
				}
			}
			System.out.println();
			System.out.print("잔고 : "+money.money+"원     ");
			showUnit();
			System.out.println("===================================================================================");
			System.out.println("무엇을 뽑으시겠습니까?");
			System.out.println("1.SCV(50), 2.Marine(50), 3.Tank(150), 4.Dropship(125), 5.MINING, 6.GIVEUP");
			int s = ScanUtil.nextInt();
			
			switch(s){
			case 1 :
				SCV scv = new SCV();
				//숫자제한
				int scnt= 0;
				for(int i = 0; i < t_SCV.length; i ++){
					if(t_SCV[i] != null){
						scnt++;
						if(scnt == t_SCV.length){
							System.out.println("***************************정원이 가득 찼습니다.************************");
							System.out.println("***************************정원이 가득 찼습니다.************************");
							System.out.println("***************************정원이 가득 찼습니다.************************");
							break;
						}
					}
				}
				if(money.money >= scv.cost){
					for(int i = 0; i < t_SCV.length; i ++){
						if(t_SCV[i] == null){
							t_SCV[i] = scv;
							money.money -= scv.cost;
							income();
							break;
						}
					}
				}else{
					System.out.println("금액이 부족합니다.");
					break;
				}
				break;
			case 2 :
				scnt= 0;
				Marine marine = new Marine();
				for(int i = 0; i < t_marine.length; i ++){
					if(t_marine[i] != null){
						scnt++;
						if(scnt == t_marine.length){
							System.out.println("***************************정원이 가득 찼습니다.************************");
							System.out.println("***************************정원이 가득 찼습니다.************************");
							System.out.println("***************************정원이 가득 찼습니다.************************");
							break;
						}
					}
				}if(money.money >= marine.cost){
					for(int i = 0; i < t_marine.length; i++){
						if(t_marine[i] == null){
							t_marine[i] = marine;
							money.money -= marine.cost;
							income();
							break;
						}
					}
				}else{
					System.out.println("금액이 부족합니다.");
					break;
				}
				break;
			case 3 : 
				scnt= 0;
				Tank tank = new Tank();
				for(int i = 0; i < t_Tank.length; i ++){
					if(t_Tank[i] != null){
						scnt++;
						if(scnt == t_Tank.length){
							System.out.println("***************************정원이 가득 찼습니다.************************");
							System.out.println("***************************정원이 가득 찼습니다.************************");
							System.out.println("***************************정원이 가득 찼습니다.************************");
							break;
						}
					}
				}if(money.money >= tank.cost){
					for(int i = 0; i < t_Tank.length; i++){
						if(t_Tank[i] == null){
							t_Tank[i] = tank;
							money.money -= tank.cost;
							income();
							break;
						}
					}
				}else{
					System.out.println("금액이 부족합니다.");
					break;
				}
				break;
			case 4 : 
				scnt= 0;
				Dropship dropship = new Dropship();
				for(int i = 0; i < t_Dropship.length; i ++){
					if(t_Dropship[i] != null){
						scnt++;
						if(scnt == t_Dropship.length){
							System.out.println("***************************정원이 가득 찼습니다.************************");
							System.out.println("***************************정원이 가득 찼습니다.************************");
							System.out.println("***************************정원이 가득 찼습니다.************************");
							break;
						}
					}
				}if(money.money >= dropship.cost){
					for(int i = 0; i < t_Dropship.length; i ++){
						if(t_Dropship[i] == null){
							t_Dropship[i] = dropship;
							money.money -= dropship.cost;
							income();
							break;
						}
					}
				}else{
					System.out.println("금액이 부족합니다.");
					break;
				}
				break;
			case 5 :
				int ran = (int)(Math.random()*10001);
				if(mining_count ==10){
					System.out.println("모든 횟수를 소모하였습니다.");
					break;
				}else{
					mining_count++;
					if(ran < 2000){
						boolean a = life();
						System.out.println("저글링이 쳐들어왔습니다!! 유닛을 빨리 뽑으세요!!");
						System.out.println("******************생명이 1 줄어들었습니다*****************");
						System.out.println("******************생명이 1 줄어들었습니다*****************");
						System.out.println("******************생명이 1 줄어들었습니다*****************");
						if(a == false){
							System.out.println("사망하셨습니다.");
							break recruit;
						}
						income();
					}else{
						income();
					}
				}
			}
			if (money.money < 50){
				boolean a = life();
				System.out.println("******************생명이 1 줄어들었습니다*****************");
				System.out.println("******************생명이 1 줄어들었습니다*****************");
				System.out.println("******************생명이 1 줄어들었습니다*****************");
				System.out.println("보유자원이 50원 이하이면 생명이 1씩 줄어듭니다!! 주의하십시오!");
				if(a == false){
					System.out.println("부족한 지휘관에 의해 용맹한 테란 전사들의 목숨이 헛되이 희생되었습니다...");
					break recruit;
				}
			}
			if(goal()==true){
				System.out.println("=======================푹찍푹찍=============================");
				System.out.println("=======================푹찍푹찍=============================");
				System.out.println("===============평화로이 잘 살고있는 저그 마을을 짓밟았습니다!!===========");
				System.out.println("===================앗! 갓 태어난 드론이 도망갑니다!!===============");
				System.out.println("우리는 승리했습니다.");
				break recruit;
			}
		System.out.println();	
		System.out.println();	
		}
	}
	void info(){
		int mcnt = 0;
		int scnt = 0;
		int dcnt = 0;
		int tcnt = 0;
		for(int i = 0; i < t_marine.length; i ++){
			if(t_marine[i] != null){
				mcnt++;
			}
		}
		for(int i = 0; i < t_SCV.length; i ++){
			if(t_SCV[i] != null){
				scnt++;
				income = scnt;
			}
		}
		for(int i = 0; i < t_Tank.length; i ++){
			if(t_Tank[i] != null){
				tcnt++;
			}
		}
		for(int i = 0; i < t_Dropship.length; i ++){
			if(t_Dropship[i] != null){
				dcnt++;
			}
		}
	}
	void showUnit(){
		int mcnt = 0;
		int scnt = 0;
		int dcnt = 0;
		int tcnt = 0;
		for(int i = 0; i < t_marine.length; i ++){
			if(t_marine[i] != null){
				mcnt++;
			}
		}
		for(int i = 0; i < t_SCV.length; i ++){
			if(t_SCV[i] != null){
				scnt++;
				income = scnt;
			}
		}
		for(int i = 0; i < t_Tank.length; i ++){
			if(t_Tank[i] != null){
				tcnt++;
			}
		}
		for(int i = 0; i < t_Dropship.length; i ++){
			if(t_Dropship[i] != null){
				dcnt++;
			}
		}
		System.out.println("SCV : "+scnt+"   Marine : "+mcnt+"   Tank : "+tcnt+"   Dropship : "+dcnt);
	}
	void income(){
		money.money += income*10;
		if(income != 0){
			System.out.println("SCV "+income+"명이 "+income*10 + "원을 캤습니다.");
		}
	}

	boolean life(){
		life--;
		boolean a= true;
	
		if(life == 0){
			a = false;	
		}
		return a;
	}
	boolean goal(){
		int mcnt = 0;
		int dcnt = 0;
		int tcnt = 0;
		boolean a = false;
		for(int i = 0; i < t_marine.length; i ++){
			if(t_marine[i] != null){
				mcnt++;
			}
		}
	
		for(int i = 0; i < t_Tank.length; i ++){
			if(t_Tank[i] != null){
				tcnt++;
			}
		}
		for(int i = 0; i < t_Dropship.length; i ++){
			if(t_Dropship[i] != null){
				dcnt++;
			}
		}
		if(mcnt==goal_M &&tcnt ==goal_T &&dcnt == goal_D){
			a =true;
		}
		return a;
	}
}
