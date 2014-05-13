import java.net.URI;
import java.net.URISyntaxException;

import org.java_websocket.client.WebSocketClient;
import org.java_websocket.drafts.Draft;
import org.java_websocket.drafts.Draft_10;
import org.java_websocket.framing.Framedata;
import org.java_websocket.handshake.ServerHandshake;

void setup(){
  try{
  ExampleClient c = new ExampleClient( new URI( "ws://localhost:4000" ), new Draft_10() ); // more about drafts here: http://github.com/TooTallNate/Java-WebSocket/wiki/Drafts
  c.connect(); 
  } 
  catch(Exception e){
    print(e);
  }
}

/** This example demonstrates how to create a websocket connection to a server. Only the most important callbacks are overloaded. */
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
