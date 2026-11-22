import java.util.Hashtable;
public class KWTable {

	private Hashtable mTable;
	public KWTable()
	{
		mTable = new Hashtable();
		mTable.put("program", new Integer(sym.PROGRAM));

		mTable.put("int", new Integer(sym.INT));
		mTable.put("char", new Integer(sym.CHAR));
		mTable.put("float", new Integer(sym.FLOAT));

		mTable.put("end", new Integer(sym.END));
	}
	
	public int find(String keyword)
	{
		Object symbol = mTable.get(keyword);
		if (symbol != null)
			return ((Integer)symbol).intValue();
		
		return sym.ID;
	}
	
}
