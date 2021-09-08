package vo;

public class UserVo {
	
	private String uid;
	private String name;
	private String hp;
	private int age;
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public void setAge(String age) {
		this.age = Integer.parseInt(age);
	}
	// 오버로딩 메서드로 만들어주기 registerservice에서 age값 받아오기 위
	

}
