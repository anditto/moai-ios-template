MOAISim.openWindow( "Textboxes", 320, 480 )

viewport = MOAIViewport.new()
viewport:setScale( 320, 480 )
viewport:setSize( 320, 480 )

layer = MOAILayer2D.new()
layer:setViewport( viewport )
MOAISim.pushRenderPass( layer )

charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
text1 = 'Test successful.........'

font = MOAIFont.new()
font:loadFromTTF( 'arialbd.ttf', charcodes, 16, 163)

textbox = MOAITextBox.new()
textbox:setFont( font )
textbox:setRect( -150, -230, 150, 230 )
textbox:setYFlip( true )
layer:insertProp( textbox )

function page( text )
  textbox:setString( text )
  textbox:spool()

  while textbox:more() do
    while textbox:isBusy() do coroutine.yield() end
    if textbox:more() then
      textbox:nextPage()
      textbox:spool()
    end
  end
end

function main()
  page( text1 )
end
thread = MOAIThread.new()
thread:run( main )
