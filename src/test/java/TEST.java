import java.security.MessageDigest;

import org.apache.commons.codec.binary.Base64;


public class TEST {

	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("bogoadmin : " + encryptPassword("sunlotto0322"));//강남빌딩10채
		System.out.println("bogo00 : " + encryptPassword("zmsqkd)"));//큰방)
		System.out.println("bogo01 : " + encryptPassword("khj800322"));//작은방!
		System.out.println("bogo02 : " + encryptPassword("ghkwkdtlf@"));//화장실@

	}
	
	public static String encryptPassword(String data) throws Exception {
		if (data == null) {
		    return "";
		}

		byte[] plainText = null; // 평문
		byte[] hashValue = null; // 해쉬값
		plainText = data.getBytes();

		MessageDigest md = MessageDigest.getInstance("SHA-256");
		hashValue = md.digest(plainText);

		/*
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(hashValue);
		*/
		return new String(Base64.encodeBase64(hashValue));
    }

}
