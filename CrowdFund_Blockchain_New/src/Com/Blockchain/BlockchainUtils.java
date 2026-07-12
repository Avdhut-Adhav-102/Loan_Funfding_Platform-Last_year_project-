package Com.Blockchain;

import java.security.MessageDigest;

public class BlockchainUtils {
    // This is the core SHA-256 Algorithm
    public static String calculateHash(String data) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(data.getBytes("UTF-8"));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    public static boolean isChainValid(String currentPrevHash, String previousHash) {
        if (previousHash == null) return true; // Genesis block case
        return currentPrevHash.equals(previousHash);
    }
}