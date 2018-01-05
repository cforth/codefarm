import json
import codecs
import logging
logging.basicConfig(level=logging.INFO)


# 从json文件路径读取
def read_json_file(json_file):
    with codecs.open(json_file, 'r', "utf-8") as f:
        data = json.load(f)
    return data


def write_python_file(file_path, string):
    with codecs.open(file_path, 'a', "utf-8") as f:
        f.write(string)


def head_string(tkinter_class):
    string =  "import tkinter as tk\n"
    string += "import tkinter.ttk as ttk\n\n\n"
    string += "class Window(%s.Frame):\n" % tkinter_class
    string += "    def __init__(self, master=None):\n"
    string += "        super().__init__(master, padding=2)\n"
    return string


def tail_string(window_name):
    string =  "\n\nif __name__ == '__main__':\n"
    string += "    app = Window()\n"
    string += "    app.master.title('%s')\n" % window_name
    string += "    app.mainloop()\n"
    return string


# 从json文件创建UI
def create_ui(json_file, output_file):
    widget = read_json_file(json_file)
    logging.info("JSON Object: %s" % str(widget))

    if not widget:
        raise NameError("JSON is empty")

    write_python_file(output_file, head_string("ttk"))

    for k in widget:
        # "class"和"grid"参数不存在直接弹出异常
        if not widget[k].get("class"):
            raise NameError("Parameter loss: class")

        if not widget[k].get("grid"):
            raise NameError("Parameter loss: grid")

        widget_class = widget[k]["class"]
        widget_grid = widget[k]["grid"]
        widget_str_parm = widget[k]["string"] if widget[k].get("string") else {}
        widget_int_parm = widget[k]["int"] if widget[k].get("int") else {}
        widget_var = widget[k]["var"] if widget[k].get("var") else None

        # 动态生成控件，并添加字符串类型的参数（若有）
        ttk_class_list = ["Progressbar", "Treeview", "Scrollbar", "Combobox", "Scale"]
        # 若控件类属于ttk控件，则使用ttk
        if widget_class in ttk_class_list:
            write_python_file(output_file, "        self.%s = ttk.%s(self, **%s, **%s)\n" %
                              (k, widget_class, str(dict(**widget_str_parm)), str(dict(**widget_int_parm))))
        # 若Button控件类有高度属性，使用tk，否则是用ttk
        elif widget_class == "Button" and "height" not in widget_int_parm:
            write_python_file(output_file, "        self.%s = ttk.%s(self, **%s, **%s)\n" %
                              (k, widget_class, str(dict(**widget_str_parm)), str(dict(**widget_int_parm))))
        else:
            write_python_file(output_file, "        self.%s = tk.%s(self, **%s, **%s)\n" %
                              (k, widget_class, str(dict(**widget_str_parm)), str(dict(**widget_int_parm))))

        # 使用grid布局控件
        if widget_grid.get("sticky"):
            grid_sticky = []
            for p in widget_grid["sticky"]:
                if p == "E":
                    grid_sticky.append("e")
                elif p == "W":
                    grid_sticky.append("w")
                elif p == "N":
                    grid_sticky.append("n")
                elif p == "S":
                    grid_sticky.append("s")
            widget_grid.pop("sticky")
            write_python_file(output_file, "        self.%s.grid(sticky=%s, **%s)\n" % (k, str(tuple(grid_sticky)), str(widget_grid)))
        else:
            write_python_file(output_file, "        self.%s.grid(**%s)\n" % (k, str(widget_grid)))

    write_python_file(output_file, "        self.grid(row=0, column=0)\n")
    write_python_file(output_file, tail_string("test"))


create_ui("UI.json", "out.py")