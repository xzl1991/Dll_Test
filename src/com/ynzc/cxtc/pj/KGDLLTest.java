package com.ynzc.cxtc.pj;

import org.xvolks.jnative.JNative;
import org.xvolks.jnative.exceptions.NativeException;
//import org.xvolks.jnative.pointers.Pointer;
//import org.xvolks.jnative.pointers.memory.MemoryBlockFactory;
import org.xvolks.jnative.Type;

public class KGDLLTest {
	static final String DLL_FILE = "SkJQJK.dll";
	public String connectServer() throws NativeException,
			IllegalAccessException {
		JNative jn_handler = null;
		jn_handler = new JNative(DLL_FILE, "connectserver");
		jn_handler.setRetVal(Type.STRING); // 指定返回参数的类型
		jn_handler.invoke(); // 调用方法
		return jn_handler.getRetVal();
	}

	public String sendStructToJson(int alldetail) throws NativeException,
			IllegalAccessException {
		JNative jn_handler = null;
		jn_handler = new JNative(DLL_FILE, "senddata");
		jn_handler.setRetVal(Type.STRING); // 指定返回参数的类型
		jn_handler.setParameter(0, "{" +
				"\"name\":\"王志坤\"," +
				"\"totalprice\":\"11000.00\"," +
				"\"itemnum\":2," +
				"\"id\":\"12345\"," +
				"\"alldetail\":"+alldetail+"," +
				"\"memo1\":\"备注1\"," +
				"\"memo2\":\"备注2 \"," +
					"\"children\":[{" +
						"\"taxname\": \"学费\"," +
						"\"taxnum\":\"1\"," +
						"\"taxunit\":\"元\"," +
						"\"taxprice\":\"10000.00\"," +
						"\"price\": \"10000.00\"," +
						"\"taxitem\": \"15\"" +
					"},{" +
					"\"taxname\": \"住宿费\"," +
					"\"taxnum\":\"1\"," +
					"\"taxunit\":\"元\"," +
					"\"taxprice\":\"1000.00\"," +
					"\"price\": \"1000.00\"," +
					"\"taxitem\": \"15\"" +
					"}]" +
				"};");
		System.out.println("\n向服务器发送的数据为：\n"+"{\n" +
													"\"name\":\"王志坤\",\n" +
													"\"totalprice\":\"11000.00\",\n" +
													"\"itemnum\":2,\n" +
													"\"id\":\"12345\",\n" +
													"\"alldetail\":"+alldetail+",\n" +
													"\"memo1\":\"备注1\",\n" +
													"\"memo2\":\"备注2 \",\n" +
														"\"children\":[{\n\t" +
															"\"taxname\": \"学费\",\n\t" +
															"\"taxnum\":\"1\",\n\t" +
															"\"taxunit\":\"元\",\n\t" +
															"\"taxprice\":\"10000.00\",\n\t" +
															"\"price\": \"10000.00\",\n\t" +
															"\"taxitem\": \"15\"\n\t" +
														"},{\n\t" +
														"\"taxname\": \"住宿费\",\n\t" +
														"\"taxnum\":\"1\",\n\t" +
														"\"taxunit\":\"元\",\n\t" +
														"\"taxprice\":\"1000.00\",\n\t" +
														"\"price\": \"1000.00\",\n\t" +
														"\"taxitem\": \"15\"\n\t" +
														"}]\n" +
													"};\n");
		jn_handler.invoke(); // 调用方法
		return jn_handler.getRetVal();
	}

	public String disconnectServer() throws NativeException,
			IllegalAccessException {
		JNative jn_handler = null;
		jn_handler = new JNative(DLL_FILE, "disconnectserver");
		jn_handler.setRetVal(Type.STRING); // 指定返回参数的类型
		jn_handler.invoke(); // 调用方法
		return jn_handler.getRetVal();
	}

	public static void main(String[] args) throws NativeException, IllegalAccessException{
		//System.out.println(System.getProperty("user.dir"));
		KGDLLTest kt = new KGDLLTest();
		String result = kt.connectServer();
		System.out.println("连接服务器：" + result);
		boolean is_connected_server = result.indexOf("100") == 0 ? true: false;
		if(! is_connected_server) {
			return;
		}
		result = kt.sendStructToJson(0);//是否打印数量、单位及单价['0':不打印;'1':打印]
		System.out.println("服务器返回消息："+result);
		result = kt.sendStructToJson(1);//是否打印数量、单位及单价['0':不打印;'1':打印]
		System.out.println("服务器返回消息："+result);
		result = kt.disconnectServer();
		System.out.println("断开服务器：" + result);
		
	}
}
