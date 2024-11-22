use std::{thread, time};
use std::num::NonZeroU32;
use std::rc::Rc;
use hyprland::data::{Client, Clients};
use hyprland::dispatch::{Dispatch, DispatchType, Position};
use hyprland::shared::{HyprData, HyprDataActiveOptional};
use rusttype::{point, Font, Scale};
use softbuffer::{Context, Surface};
use winit::dpi::LogicalPosition;
use winit::platform::wayland::WindowAttributesExtWayland;
use winit::{application::ApplicationHandler, dpi::LogicalSize, event::WindowEvent, event_loop::{ActiveEventLoop, EventLoop}, window::Window};
#[derive(Default)]
struct App<'a> {
    window: Option<Rc<Window>>,
    surface: Option<Surface<Rc<Window>, Rc<Window>>>,
    font: Option<Font<'a>>,
    frame_count: u32,
    width: u32,
}

impl<'a> ApplicationHandler for App<'a> {
    fn resumed(&mut self, event_loop: &ActiveEventLoop) {

        let font = Font::try_from_bytes(FONT_DATA).expect("Failed to load font");

        let window = {
            let window = event_loop.create_window(
            Window::default_attributes()
                .with_inner_size(LogicalSize::new(1080, 50))
                .with_position(LogicalPosition::new(0, 0))
                .with_title("rust-bar")
                .with_name("org.rust-bar.dock", "")
            ).unwrap();
            Rc::new(window)
        };


        

        self.window = Some(window.clone());
        
        let window_size = self.window.as_ref().unwrap().inner_size();
        dbg!(window_size);
        dbg!("surf");
        let context = Context::new(window.clone()).unwrap();
        self.surface = Some(Surface::new(&context, window).unwrap());
        dbg!("pix");
        self.font = Some(font);
        self.width = window_size.width;

    } 

    fn window_event(
            &mut self,
            event_loop: &ActiveEventLoop,
            window_id: winit::window::WindowId,
            event: winit::event::WindowEvent,
        ) {
        match event {
            WindowEvent::Focused(t) => {
                if t {
                    let clients = Clients::get().unwrap();
                    let act = clients.iter().find(|x| x.title == "rust-bar").unwrap();
                    println!("Focused");
                    if act.floating == false {
                        Dispatch::call(DispatchType::ToggleFloating(None)).unwrap();
                    }
                    Dispatch::call(DispatchType::MoveActive(Position::Exact(0, 0))).unwrap();
                    if act.pinned == false {
                        Dispatch::call(DispatchType::TogglePin).unwrap();
                    }
                }
            }
            WindowEvent::Resized(new_size) => {
                if let Some(surface) = &mut self.surface {
                     surface.resize(NonZeroU32::new(new_size.width).unwrap(), NonZeroU32::new(new_size.height).unwrap());
                    self.width = new_size.width;
                } else {
                    eprintln!("No buffer present!");
                }
            }
            WindowEvent::CloseRequested => {
                dbg!("Close");
                self.surface = None;
                self.window = None;
                self.font = None;
                event_loop.exit();
            }
            WindowEvent::RedrawRequested => {
                dbg!("Redraw");
                if let Some(surface) = &mut self.surface {
                    let mut buffer = surface.buffer_mut().unwrap();
                    buffer.fill(0);
                    println!("frame {}", self.frame_count);

                

                    let scale = Scale::uniform(48.0);
                    let point = point(100.0, 100.0);
                    for glyph in self.font.as_ref().unwrap().layout("Hello, World!", scale, point) {
                        if let Some(bb) = glyph.pixel_bounding_box() {
                            glyph.draw(|x, y, v| {
                                if v > 0.5 {
                                    let x = x + bb.min.x as u32;
                                    let y = y + bb.min.y as u32;
                                    let index = (y * self.width + x) as usize;
                                    if index < buffer.len() {
                                        buffer[index] = u32::from_be_bytes([0, 255, 255, 255]);
                                    }                           
                                }
                            });
                        }
                    }
                    println!("glyph {}", self.frame_count);

                    buffer.present().unwrap();
                    println!("render {}", self.frame_count);
                
                    self.frame_count += 1;

                    thread::sleep(time::Duration::from_millis(16));
                    self.window.as_ref().unwrap().request_redraw();
                }
            }

            _ => (),
        }   
    }
}

const FONT_DATA : &[u8; 2156096] = include_bytes!("./bar-font.ttf");

fn main() {

    
    let event_loop = EventLoop::new().unwrap();
    let mut app = App::default();
    event_loop.run_app(&mut app);
      
}



