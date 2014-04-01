import org.java_websocket.handshake.*;
import org.java_websocket.server.*;
import org.java_websocket.exceptions.*;
import org.java_websocket.*;
import org.java_websocket.client.*;
import org.java_websocket.drafts.*;
import org.java_websocket.framing.*;
import org.java_websocket.util.*;

import java.net.URI;
import java.net.URISyntaxException;

import org.java_websocket.client.WebSocketClient;
import org.java_websocket.drafts.Draft;
import org.java_websocket.drafts.Draft_10;
import org.java_websocket.framing.Framedata;
import org.java_websocket.handshake.ServerHandshake;

private WebSocketClient cc;
void setup(){
  try{
  //new ExampleClient( new URI( "ws://localhost:3000" ), new Draft_10() ); 
  // more about drafts here: http://github.com/TooTallNate/Java-WebSocket/wiki/Drafts
  cc = new WebSocketClient( new URI( "ws://localhost:3000" ), new Draft_10() ) {
    @Override
    public void onMessage( String message ) {
      System.out.println("received " + message);
    }
    @Override
    public void onOpen( ServerHandshake handshake ) {
      System.out.println("opened");
    }
    @Override
    public void onClose( int code, String reason, boolean remote ) {
 
    }
    @Override
    public void onError( Exception ex ) {
 
    }
  };
  cc.connect();
  cc.send("test");
  } 
  catch(Exception e){
    print(e);
  }
}

public class ExampleClient extends WebSocketClient {

        public ExampleClient( URI serverUri , Draft draft ) {
                super( serverUri, draft );
        }

        public ExampleClient( URI serverURI ) {
                super( serverURI );
        }

        @Override
        public void onOpen( ServerHandshake handshakedata ) {
                System.out.println( "opened connection" );
                this.send("test");
        }
        
        @Override
        public void send( String message ) {
                System.out.println( "Sending " + message );
        }

        @Override
        public void onMessage( String message ) {
                System.out.println( message );
        }

        @Override
        public void onClose( int code, String reason, boolean remote ) {
                // The codecodes are documented in class org.java_websocket.framing.CloseFrame
                System.out.println( "Connection closed by " + ( remote ? "remote peer" : "us" ) );
        }

        @Override
        public void onError( Exception ex ) {
                ex.printStackTrace();

        }

}
